//
//  DesignSystem.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
import LucideIcons
#endif

extension Font {
    static func appSerif(size: CGFloat) -> Font {
        .custom(AppFonts.dmSerifDisplay, size: size)
    }

    static func appSans(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom(AppFonts.inter, size: size)
            .weight(weight)
    }
}

struct RiadCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.appWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.warmNeutralBorder.opacity(0.55), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
    }
}

extension View {
    func riadCard() -> some View {
        modifier(RiadCardModifier())
    }
}

enum RiadMotion {
    static let screen = Animation.spring(response: 0.42, dampingFraction: 0.90, blendDuration: 0.12)
    static let state = Animation.spring(response: 0.28, dampingFraction: 0.88, blendDuration: 0.08)
    static let data = Animation.timingCurve(0.16, 1, 0.3, 1, duration: 0.78)
    static let press = Animation.spring(response: 0.18, dampingFraction: 0.86)
    static let reduced = Animation.easeOut(duration: 0.16)
}

private struct RiadTabTransitionModifier: ViewModifier {
    let opacity: Double
    let horizontalOffset: CGFloat

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(x: horizontalOffset)
    }
}

struct RiadPressStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.975 : 1)
            .opacity(!isEnabled ? 0.46 : (configuration.isPressed ? 0.76 : 1))
            .animation(reduceMotion ? nil : RiadMotion.press, value: configuration.isPressed)
    }
}

private struct RiadCarouselItemModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        if reduceMotion {
            content
        } else {
            content
                .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                    content
                        .scaleEffect(phase.isIdentity ? 1 : 0.965)
                        .opacity(phase.isIdentity ? 1 : 0.78)
                }
        }
    }
}

extension View {
    func riadCarouselItem() -> some View {
        modifier(RiadCarouselItemModifier())
    }
}

extension AnyTransition {
    static func riadTab(direction: CGFloat, reduceMotion: Bool) -> AnyTransition {
        guard !reduceMotion else { return .opacity }

        return .asymmetric(
            insertion: .modifier(
                active: RiadTabTransitionModifier(opacity: 0, horizontalOffset: 24 * direction),
                identity: RiadTabTransitionModifier(opacity: 1, horizontalOffset: 0)
            ),
            removal: .modifier(
                active: RiadTabTransitionModifier(opacity: 0, horizontalOffset: -14 * direction),
                identity: RiadTabTransitionModifier(opacity: 1, horizontalOffset: 0)
            )
        )
    }
}

struct LucideIcon: View {
    let name: String
    let fallbackSystemName: String
    var size: CGFloat = 24

    var body: some View {
        #if canImport(UIKit)
        if let image = UIImage(lucideId: name) {
            Image(uiImage: image.withRenderingMode(.alwaysTemplate))
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            Image(systemName: fallbackSystemName)
                .font(.system(size: size, weight: .regular))
        }
        #else
        Image(systemName: fallbackSystemName)
            .font(.system(size: size, weight: .regular))
        #endif
    }
}

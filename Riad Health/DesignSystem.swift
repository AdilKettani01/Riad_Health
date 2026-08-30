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

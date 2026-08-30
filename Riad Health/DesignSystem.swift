//
//  DesignSystem.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

extension Color {
    static let appWhite = Color("AppWhite")
    static let creamBackground = Color("CreamBackground")
    static let darkText = Color("DarkText")
    static let mutedText = Color("MutedText")
    static let paleSage = Color("PaleSage")
    static let primaryGreen = Color("PrimaryGreen")
    static let secondarySage = Color("SecondarySage")
    static let successGreen = Color("SuccessGreen")
    static let warmNeutralBorder = Color("WarmNeutralBorder")
}

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

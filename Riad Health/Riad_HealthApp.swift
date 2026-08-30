//
//  Riad_HealthApp.swift
//  Riad Health
//
//  Created by Adil Kettani on 29/8/2026.
//

import SwiftUI
import CoreText

@main
struct Riad_HealthApp: App {
    init() {
        AppFonts.registerFonts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

enum AppFonts {
    static let dmSerifDisplay = "DMSerifDisplay-Regular"
    static let inter = "Inter-Regular"

    static func registerFonts() {
        registerFont(named: "DMSerifDisplay-Regular", extension: "ttf")
        registerFont(named: "Inter-VariableFont_opsz,wght", extension: "ttf")
    }

    private static func registerFont(named name: String, extension fileExtension: String) {
        let fontURL = Bundle.main.url(forResource: name, withExtension: fileExtension)
            ?? Bundle.main.url(forResource: name, withExtension: fileExtension, subdirectory: "fonts")

        guard let fontURL else {
            print("Font file not found: \(name).\(fileExtension)")
            return
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
    }
}

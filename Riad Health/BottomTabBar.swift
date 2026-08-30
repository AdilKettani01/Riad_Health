//
//  BottomTabBar.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case home = "Home"
    case tracking = "Tracking"
    case shop = "Shop"
    case insights = "Insights"
    case profile = "Profile"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .tracking:
            return "chart.xyaxis.line"
        case .shop:
            return "bag"
        case .insights:
            return "lightbulb"
        case .profile:
            return "person"
        }
    }
}

struct BottomTabBar: View {
    let selectedTab: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                BottomTabItem(tab: tab, isSelected: tab == selectedTab)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Divider()
                .overlay(Color.warmNeutralBorder.opacity(0.65))
        }
    }
}

struct BottomTabItem: View {
    let tab: AppTab
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.icon)
                .font(.system(size: 24, weight: .medium))
                .frame(width: 30, height: 28)

            Text(tab.rawValue)
                .font(.appSans(size: 12, weight: isSelected ? .semibold : .regular))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .foregroundStyle(isSelected ? Color.primaryGreen : Color.mutedText)
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    BottomTabBar(selectedTab: .home)
        .background(Color.creamBackground)
}

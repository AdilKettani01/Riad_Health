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
            return "house"
        case .tracking:
            return "chart-no-axes-column-increasing"
        case .shop:
            return "shopping-bag"
        case .insights:
            return "lightbulb"
        case .profile:
            return "face-slightly-smiling"
        }
    }

    var fallbackIcon: String {
        switch self {
        case .home:
            return "house"
        case .tracking:
            return "chart.bar"
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
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    BottomTabItem(tab: tab, isSelected: tab == selectedTab)
                }
                .buttonStyle(.plain)
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
            LucideIcon(name: tab.icon, fallbackSystemName: tab.fallbackIcon, size: 24)
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
    BottomTabBar(selectedTab: .constant(.tracking))
        .background(Color.creamBackground)
}

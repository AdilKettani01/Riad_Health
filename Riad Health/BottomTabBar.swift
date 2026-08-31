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

    var position: Int {
        AppTab.allCases.firstIndex(of: self) ?? 0
    }

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
    let selectedTab: AppTab
    let onSelect: (AppTab) -> Void
    @Namespace private var selectionNamespace

    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(AppTab.allCases) { tab in
                    Button {
                        onSelect(tab)
                    } label: {
                        BottomTabItem(
                            tab: tab,
                            isSelected: tab == selectedTab,
                            selectionNamespace: selectionNamespace
                        )
                    }
                    .buttonStyle(RiadPressStyle())
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(Color.warmNeutralBorder.opacity(0.55), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.12), radius: 18, x: 0, y: 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
        .sensoryFeedback(.selection, trigger: selectedTab)
    }
}

struct BottomTabItem: View {
    let tab: AppTab
    let isSelected: Bool
    let selectionNamespace: Namespace.ID

    var body: some View {
        VStack(spacing: 5) {
            LucideIcon(name: tab.icon, fallbackSystemName: tab.fallbackIcon, size: 24)
                .frame(width: 28, height: 26)

            Text(tab.rawValue)
                .font(.appSans(size: 11, weight: isSelected ? .bold : .medium))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 6)
        .foregroundStyle(isSelected ? Color.primaryGreen : Color.mutedText)
        .background {
            if isSelected {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.paleSage.opacity(0.9))
                    .matchedGeometryEffect(id: "selectedTab", in: selectionNamespace)
            }
        }
        .scaleEffect(isSelected ? 1 : 0.985)
        .animation(RiadMotion.state, value: isSelected)
        .frame(maxWidth: .infinity, minHeight: 58)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    BottomTabBar(selectedTab: .tracking, onSelect: { _ in })
        .background(Color.creamBackground)
}

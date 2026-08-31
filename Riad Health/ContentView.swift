//
//  ContentView.swift
//  Riad Health
//
//  Created by Adil Kettani on 29/8/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.creamBackground
                .ignoresSafeArea()

            Group {
                switch selectedTab {
                case .home:
                    HomeScreen()
                case .tracking:
                    TrackingScreen()
                case .shop:
                    ShopScreen()
                case .insights:
                    InsightsScreen()
                case .profile:
                    ProfileScreen()
                }
            }

            BottomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct HomeScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Header(title: "Riad Health")

                GreetingView(name: "Adil", day: 42)

                HealthScoreSummary(
                    score: 82,
                    leftMetric: HealthMetric(
                        title: "Diversity",
                        value: "High",
                        icon: "blend"
                    ),
                    rightMetric: HealthMetric(
                        title: "Inflam...",
                        value: "Low",
                        icon: "waveform.path.ecg"
                    )
                )

                ProductCarousel()

                InsightBanner(message: "Your fiber intake is trending up - nice work")

                ShipmentCard()

                TrendCard()

                GoalProgressRow()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 104)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Riad Health
//
//  Created by Adil Kettani on 29/8/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.creamBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    Header()

                    GreetingView(name: "Alex", day: 42)

                    HealthScoreSummary(
                        score: 82,
                        leftMetric: HealthMetric(
                            title: "Diversity",
                            value: "High",
                            icon: "sparkles"
                        ),
                        rightMetric: HealthMetric(
                            title: "Inflammation",
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

            BottomTabBar(selectedTab: .home)
        }
    }
}

#Preview {
    ContentView()
}

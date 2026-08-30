//
//  InsightsScreen.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

struct InsightsScreen: View {
    private let horizontalPadding: CGFloat = 24

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Header(title: "Insights")

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your weekly story")
                            .font(.appSerif(size: 34))
                            .foregroundStyle(Color.darkText)

                        Text("Small patterns, meaningful progress.")
                            .font(.appSans(size: 18))
                            .foregroundStyle(Color.mutedText)
                    }

                    WeeklyStoryCard()
                    WhatChangedCard()
                    InsightTwoColumnCards()
                    TryNextCard()
                    MonthlySnapshotCard()
                }
                .frame(width: geometry.size.width - horizontalPadding * 2, alignment: .leading)
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 16)
                .padding(.bottom, 104)
            }
        }
    }
}

struct WeeklyStoryCard: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 18) {
                        LucideIcon(name: "sparkles", fallbackSystemName: "sparkles", size: 38)
                            .foregroundStyle(Color.primaryGreen)

                        Text("THIS WEEK")
                            .font(.appSans(size: 12, weight: .semibold))
                            .foregroundStyle(Color.primaryGreen)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 7)
                            .background(Color.paleSage.opacity(0.9), in: Capsule())
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your routine is working for you")
                            .font(.appSerif(size: 27))
                            .foregroundStyle(Color.darkText)
                            .lineLimit(2)

                        Text("On days you met your fiber goal, your energy check-ins were 18% higher.")
                            .font(.appSans(size: 16))
                            .foregroundStyle(Color.darkText)
                            .lineSpacing(3)
                            .lineLimit(3)
                    }

                    Button {
                    } label: {
                        Label("See the pattern", systemImage: "arrow.right")
                            .labelStyle(.titleAndIcon)
                            .font(.appSans(size: 15, weight: .semibold))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(Color.darkText)
                }

                Spacer(minLength: 70)
            }

            MoleculePattern()
                .stroke(Color.secondarySage.opacity(0.2), lineWidth: 2)
                .frame(width: 170, height: 160)
                .offset(x: 28, y: 18)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.paleSage.opacity(0.7), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

struct WhatChangedCard: View {
    private let changes = [
        InsightChange(title: "Fiber consistency", value: "+12%", icon: "wheat", fallback: "leaf", points: [0.25, 0.32, 0.29, 0.38, 0.35, 0.5, 0.43, 0.58, 0.55, 0.72]),
        InsightChange(title: "Diversity trend", value: "+6 pts", icon: "blend", fallback: "circle.grid.3x3", points: [0.2, 0.28, 0.25, 0.36, 0.4, 0.38, 0.52, 0.47, 0.56, 0.68]),
        InsightChange(title: "Digestive comfort", value: "Improving", icon: "worm", fallback: "waveform.path.ecg", points: [0.45, 0.36, 0.42, 0.34, 0.4, 0.35, 0.52, 0.43, 0.5, 0.64])
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text("What changed")
                    .font(.appSans(size: 17, weight: .semibold))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Text("vs last 7 days")
                    .font(.appSans(size: 12))
                    .foregroundStyle(Color.mutedText)
            }

            VStack(spacing: 0) {
                ForEach(changes) { change in
                    InsightChangeRow(change: change)

                    if change.id != changes.last?.id {
                        Divider()
                            .padding(.leading, 72)
                    }
                }
            }
            .riadCard()
        }
    }
}

struct InsightChange: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
    let fallback: String
    let points: [CGFloat]
}

struct InsightChangeRow: View {
    let change: InsightChange

    var body: some View {
        HStack(spacing: 10) {
            LucideIcon(name: change.icon, fallbackSystemName: change.fallback, size: 24)
                .foregroundStyle(Color.primaryGreen)
                .frame(width: 44, height: 44)
                .background(Color.paleSage.opacity(0.7), in: Circle())

            Text(change.title)
                .font(.appSans(size: 14, weight: .medium))
                .foregroundStyle(Color.darkText)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Spacer()

            Sparkline(values: change.points)
                .frame(width: 72, height: 26)

            Text(change.value)
                .font(.appSans(size: 14, weight: .semibold))
                .foregroundStyle(Color.primaryGreen)
                .lineLimit(2)
                .minimumScaleFactor(0.72)
                .frame(width: 58, alignment: .trailing)

            Image(systemName: "chevron.right")
                .font(.appSans(size: 12, weight: .semibold))
                .foregroundStyle(Color.mutedText)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 11)
    }
}

struct Sparkline: View {
    let values: [CGFloat]

    var body: some View {
        GeometryReader { geometry in
            let points = values.enumerated().map { index, value in
                CGPoint(
                    x: CGFloat(index) / CGFloat(values.count - 1) * geometry.size.width,
                    y: (1 - value) * geometry.size.height
                )
            }

            Path { path in
                guard let first = points.first else { return }
                path.move(to: first)
                points.dropFirst().forEach { path.addLine(to: $0) }
            }
            .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }
}

struct InsightTwoColumnCards: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            StrongestHabitCard()
            ScienceCard()
        }
    }
}

struct StrongestHabitCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Your strongest habit")
                .font(.appSans(size: 16, weight: .medium))
                .foregroundStyle(Color.darkText)

            HStack(spacing: 16) {
                ZStack {
                    MiniProgressRing(progress: 0.86)
                        .scaleEffect(1.28)

                    VStack(spacing: 0) {
                        Text("6")
                            .font(.appSerif(size: 32))
                            .foregroundStyle(Color.primaryGreen)

                        Text("day\nstreak")
                            .font(.appSans(size: 11, weight: .medium))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.darkText)
                    }
                }
                .frame(width: 80, height: 80)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Morning synbiotic")
                        .font(.appSans(size: 18, weight: .semibold))
                        .foregroundStyle(Color.darkText)
                        .lineLimit(2)

                    Text("Keep it going!")
                        .font(.appSans(size: 13))
                        .foregroundStyle(Color.mutedText)
                }
            }

            HabitWeekDots()
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 218, alignment: .topLeading)
        .riadCard()
    }
}

struct HabitWeekDots: View {
    private let days = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(days.enumerated()), id: \.offset) { index, day in
                VStack(spacing: 6) {
                    Text(day)
                        .font(.appSans(size: 12, weight: .medium))
                        .foregroundStyle(Color.darkText)

                    ZStack {
                        Circle()
                            .fill(index < 6 ? Color.primaryGreen : Color.appWhite)
                            .frame(width: 18, height: 18)
                            .overlay(Circle().stroke(Color.secondarySage, lineWidth: 1.2))

                        if index < 6 {
                            Image(systemName: "checkmark")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
}

struct ScienceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("From the science")
                .font(.appSans(size: 16, weight: .medium))
                .foregroundStyle(Color.darkText)

            HStack(spacing: 12) {
                LeafAccent()
                    .stroke(Color.secondarySage.opacity(0.75), lineWidth: 1.4)
                    .frame(width: 70, height: 82)

                MicrobePlate()
                    .frame(width: 76, height: 76)
            }
            .frame(maxWidth: .infinity)

            Text("Why diverse plants matter")
                .font(.appSans(size: 17, weight: .semibold))
                .foregroundStyle(Color.darkText)
                .lineLimit(2)

            Text("A varied plant intake supports a more diverse gut microbiome.")
                .font(.appSans(size: 13))
                .foregroundStyle(Color.mutedText)
                .lineLimit(3)

            HStack {
                Text("3 min read")
                    .font(.appSans(size: 12))
                    .foregroundStyle(Color.mutedText)

                Spacer()

                LucideIcon(name: "bookmark", fallbackSystemName: "bookmark", size: 20)
                    .foregroundStyle(Color.mutedText)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 218, alignment: .topLeading)
        .riadCard()
    }
}

struct MicrobePlate: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.paleSage.opacity(0.65))
                .overlay(Circle().stroke(Color.secondarySage.opacity(0.4), lineWidth: 1))

            ForEach(0..<9, id: \.self) { index in
                Capsule()
                    .fill(index.isMultiple(of: 2) ? Color.primaryGreen.opacity(0.65) : Color.secondarySage.opacity(0.55))
                    .frame(width: 18, height: 7)
                    .rotationEffect(.degrees(Double(index * 31)))
                    .offset(
                        x: cos(CGFloat(index) * 0.82) * 23,
                        y: sin(CGFloat(index) * 0.82) * 23
                    )
            }
        }
    }
}

struct TryNextCard: View {
    var body: some View {
        HStack(spacing: 16) {
            LucideIcon(name: "sprout", fallbackSystemName: "leaf", size: 30)
                .foregroundStyle(Color.primaryGreen)
                .frame(width: 58, height: 58)
                .background(Color.paleSage.opacity(0.75), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text("Try this next")
                    .font(.appSans(size: 14, weight: .semibold))
                    .foregroundStyle(Color.darkText)

                Text("Add one extra plant today")
                    .font(.appSans(size: 17, weight: .medium))
                    .foregroundStyle(Color.darkText)

                Text("A simple step toward more diversity.")
                    .font(.appSans(size: 14))
                    .foregroundStyle(Color.mutedText)
            }

            Spacer()

            Button {
            } label: {
                Label("View ideas", systemImage: "chevron.right")
                    .labelStyle(.titleAndIcon)
                    .font(.appSans(size: 14, weight: .semibold))
                    .padding(.horizontal, 16)
                    .frame(height: 48)
                    .background(Color.paleSage.opacity(0.75), in: Capsule())
            }
            .buttonStyle(.plain)
            .foregroundStyle(Color.primaryGreen)
        }
        .padding(18)
        .riadCard()
    }
}

struct MonthlySnapshotCard: View {
    private let values: [CGFloat] = [38, 39, 51, 46, 58, 63, 75, 68, 70, 66, 76, 84, 78, 88, 94, 84, 92, 95]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Monthly snapshot")
                    .font(.appSans(size: 17, weight: .medium))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Label("Last 30 days", systemImage: "chevron.down")
                    .labelStyle(.titleAndIcon)
                    .font(.appSans(size: 13, weight: .medium))
                    .foregroundStyle(Color.mutedText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay {
                        Capsule()
                            .stroke(Color.warmNeutralBorder.opacity(0.8), lineWidth: 1)
                    }
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 6) {
                    Text("Gut Health Score")
                        .font(.appSans(size: 16, weight: .semibold))
                        .foregroundStyle(Color.darkText)

                    LucideIcon(name: "info", fallbackSystemName: "info.circle", size: 16)
                        .foregroundStyle(Color.mutedText)
                }

                SnapshotChart(values: values)
                    .frame(height: 150)
            }
            .padding(16)
            .riadCard()
        }
    }
}

struct SnapshotChart: View {
    let values: [CGFloat]

    var body: some View {
        GeometryReader { geometry in
            let points = chartPoints(in: geometry.size)

            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    ForEach(["100", "75", "50", "25", "0"], id: \.self) { label in
                        HStack(spacing: 8) {
                            Text(label)
                                .font(.appSans(size: 11))
                                .foregroundStyle(Color.mutedText)
                                .frame(width: 30, alignment: .leading)

                            Divider()
                                .overlay(Color.warmNeutralBorder.opacity(0.38))
                        }
                        Spacer()
                    }
                }

                Path { path in
                    guard let first = points.first else { return }
                    path.move(to: first)
                    points.dropFirst().forEach { path.addLine(to: $0) }
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .offset(x: 30)
                .fill(Color.paleSage.opacity(0.55))

                Path { path in
                    guard let first = points.first else { return }
                    path.move(to: first)
                    points.dropFirst().forEach { path.addLine(to: $0) }
                }
                .offset(x: 30)
                .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 2.4, lineCap: .round, lineJoin: .round))

                if let last = points.last {
                    Text("82")
                        .font(.appSans(size: 13, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 8)
                        .background(Color.primaryGreen, in: RoundedRectangle(cornerRadius: 6))
                        .position(x: last.x + 30, y: max(last.y - 30, 18))

                    Circle()
                        .fill(Color.primaryGreen)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(Color.secondarySage, lineWidth: 2))
                        .position(x: last.x + 30, y: last.y)
                }
            }
            .padding(.trailing, 30)
        }
    }

    private func chartPoints(in size: CGSize) -> [CGPoint] {
        values.enumerated().map { index, value in
            CGPoint(
                x: CGFloat(index) / CGFloat(values.count - 1) * (size.width - 60),
                y: (1 - value / 100) * (size.height - 18) + 9
            )
        }
    }
}

struct MoleculePattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let nodes = [
            CGPoint(x: rect.minX + rect.width * 0.18, y: rect.minY + rect.height * 0.24),
            CGPoint(x: rect.minX + rect.width * 0.42, y: rect.minY + rect.height * 0.36),
            CGPoint(x: rect.minX + rect.width * 0.54, y: rect.minY + rect.height * 0.68),
            CGPoint(x: rect.minX + rect.width * 0.82, y: rect.minY + rect.height * 0.5)
        ]

        for pair in zip(nodes, nodes.dropFirst()) {
            path.move(to: pair.0)
            path.addLine(to: pair.1)
        }

        for point in nodes {
            path.addEllipse(in: CGRect(x: point.x - 8, y: point.y - 8, width: 16, height: 16))
        }

        return path
    }
}

#Preview {
    InsightsScreen()
        .background(Color.creamBackground)
}

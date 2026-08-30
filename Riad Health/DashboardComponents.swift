//
//  DashboardComponents.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

struct ShipmentCard: View {
    private let steps = [
        ShipmentStep(title: "Ordered", date: "May 6", state: .complete),
        ShipmentStep(title: "Processing", date: "May 7", state: .complete),
        ShipmentStep(title: "In transit", date: "May 8", state: .current),
        ShipmentStep(title: "Delivered", date: "May 13", state: .upcoming)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Label("Next shipment arrives in 5 days", systemImage: "truck.box")
                .font(.appSans(size: 18, weight: .medium))
                .foregroundStyle(Color.darkText)

            HStack(alignment: .top, spacing: 0) {
                ForEach(steps) { step in
                    ShipmentStepView(step: step)
                }
            }

            HStack {
                Spacer()

                Button {
                } label: {
                    Label("Manage subscription", systemImage: "chevron.right")
                        .labelStyle(.titleAndIcon)
                        .font(.appSans(size: 16, weight: .semibold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.primaryGreen)
            }
        }
        .padding(18)
        .riadCard()
    }
}

struct ShipmentStep: Identifiable {
    enum State {
        case complete
        case current
        case upcoming
    }

    let id = UUID()
    let title: String
    let date: String
    let state: State
}

struct ShipmentStepView: View {
    let step: ShipmentStep

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .fill(lineColor)
                    .frame(height: 3)
                    .offset(x: 32)

                Circle()
                    .fill(circleFill)
                    .frame(width: 22, height: 22)
                    .overlay {
                        Circle()
                            .stroke(Color.primaryGreen, lineWidth: step.state == .upcoming ? 0 : 2)
                    }

                if step.state == .complete {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            .frame(height: 24)

            Text(step.title)
                .font(.appSans(size: 12, weight: step.state == .current ? .semibold : .regular))
                .foregroundStyle(step.state == .current ? Color.primaryGreen : Color.darkText)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Text(step.date)
                .font(.appSans(size: 12))
                .foregroundStyle(step.state == .current ? Color.primaryGreen : Color.mutedText)
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }

    private var circleFill: Color {
        switch step.state {
        case .complete:
            return .primaryGreen
        case .current:
            return .paleSage
        case .upcoming:
            return .appWhite
        }
    }

    private var lineColor: Color {
        step.state == .upcoming ? Color.warmNeutralBorder : Color.primaryGreen
    }
}

struct TrendCard: View {
    private let values: [CGFloat] = [24, 32, 30, 43, 40, 50, 52, 64, 56, 58, 66, 75, 74, 80, 73, 68, 76, 80, 88, 82]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Diversity trend")
                    .font(.appSerif(size: 24))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Label("30 days", systemImage: "chevron.down")
                    .labelStyle(.titleAndIcon)
                    .font(.appSans(size: 14, weight: .semibold))
                    .foregroundStyle(Color.darkText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.warmNeutralBorder, lineWidth: 1)
                    }
            }

            LineChart(values: values)
                .frame(height: 150)
        }
        .padding(18)
        .riadCard()
    }
}

struct LineChart: View {
    let values: [CGFloat]

    var body: some View {
        GeometryReader { geometry in
            let points = chartPoints(in: geometry.size)

            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { _ in
                        Divider()
                            .overlay(Color.warmNeutralBorder.opacity(0.45))
                        Spacer()
                    }
                }

                Path { path in
                    guard let firstPoint = points.first else { return }
                    path.move(to: firstPoint)
                    points.dropFirst().forEach { path.addLine(to: $0) }
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.paleSage.opacity(0.65))

                Path { path in
                    guard let firstPoint = points.first else { return }
                    path.move(to: firstPoint)
                    points.dropFirst().forEach { path.addLine(to: $0) }
                }
                .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))

                if let lastPoint = points.last {
                    Circle()
                        .fill(Color.primaryGreen)
                        .frame(width: 16, height: 16)
                        .overlay(Circle().stroke(Color.appWhite, lineWidth: 3))
                        .position(lastPoint)

                    Text("82\nMay 13")
                        .font(.appSans(size: 12, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Color.primaryGreen, in: RoundedRectangle(cornerRadius: 6))
                        .position(x: max(lastPoint.x - 8, 36), y: min(lastPoint.y + 48, geometry.size.height - 28))
                }
            }
        }
    }

    private func chartPoints(in size: CGSize) -> [CGPoint] {
        guard let minValue = values.min(), let maxValue = values.max(), maxValue > minValue else {
            return []
        }

        return values.enumerated().map { index, value in
            let progress = CGFloat(index) / CGFloat(values.count - 1)
            let normalized = (value - minValue) / (maxValue - minValue)
            return CGPoint(
                x: progress * size.width,
                y: (1 - normalized) * (size.height - 18) + 9
            )
        }
    }
}

struct GoalProgressRow: View {
    private let goals = [
        GoalProgress(title: "Fiber", current: "24 g", target: "of 33 g", progress: 0.72),
        GoalProgress(title: "Fermented Foods", current: "7", target: "of 12 servings", progress: 0.56),
        GoalProgress(title: "Water", current: "2.1 L", target: "of 2.5 L", progress: 0.84)
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(goals) { goal in
                GoalProgressCell(goal: goal)

                if goal.id != goals.last?.id {
                    Divider()
                        .padding(.vertical, 14)
                }
            }
        }
        .frame(height: 118)
        .riadCard()
    }
}

struct GoalProgress: Identifiable {
    let id = UUID()
    let title: String
    let current: String
    let target: String
    let progress: CGFloat
}

struct GoalProgressCell: View {
    let goal: GoalProgress

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(goal.title)
                    .font(.appSans(size: 14, weight: .semibold))
                    .foregroundStyle(Color.darkText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.appSans(size: 13, weight: .semibold))
                    .foregroundStyle(Color.mutedText)
            }

            HStack(spacing: 10) {
                MiniProgressRing(progress: goal.progress)

                VStack(alignment: .leading, spacing: 2) {
                    Text(goal.current)
                        .font(.appSans(size: 17, weight: .bold))
                        .foregroundStyle(Color.darkText)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text(goal.target)
                        .font(.appSans(size: 12))
                        .foregroundStyle(Color.mutedText)
                        .lineLimit(2)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MiniProgressRing: View {
    let progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.secondarySage.opacity(0.35), lineWidth: 5)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Text("\(Int(progress * 100))%")
                .font(.appSans(size: 12, weight: .bold))
                .foregroundStyle(Color.darkText)
        }
        .frame(width: 52, height: 52)
    }
}

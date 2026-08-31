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

            ShipmentProgressView(steps: steps)

            HStack {
                Spacer()

                NavigationLink(value: AppRoute.subscription) {
                    Label("Manage subscription", systemImage: "chevron.right")
                        .labelStyle(.titleAndIcon)
                        .font(.appSans(size: 16, weight: .semibold))
                }
                .buttonStyle(RiadPressStyle())
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

struct ShipmentProgressView: View {
    let steps: [ShipmentStep]
    private let circleSize: CGFloat = 30
    private let lineHeight: CGFloat = 5
    private let topInset: CGFloat = 4

    var body: some View {
        GeometryReader { geometry in
            let stepWidth = geometry.size.width / CGFloat(steps.count)
            let centers = steps.indices.map { index in
                stepWidth * (CGFloat(index) + 0.5)
            }

            ZStack(alignment: .topLeading) {
                ForEach(steps.indices.dropLast(), id: \.self) { index in
                    Capsule()
                        .fill(lineColor(after: steps[index]))
                        .frame(
                            width: centers[index + 1] - centers[index] - circleSize,
                            height: lineHeight
                        )
                        .position(
                            x: (centers[index] + centers[index + 1]) / 2,
                            y: topInset + circleSize / 2
                        )
                }

                HStack(alignment: .top, spacing: 0) {
                    ForEach(steps) { step in
                        ShipmentStepView(step: step, circleSize: circleSize)
                            .frame(width: stepWidth)
                    }
                }
                .padding(.top, topInset)
            }
        }
        .frame(height: 100)
    }

    private func lineColor(after step: ShipmentStep) -> Color {
        step.state == .complete ? Color.primaryGreen : Color.warmNeutralBorder
    }
}

struct ShipmentStepView: View {
    let step: ShipmentStep
    let circleSize: CGFloat

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(circleFill)
                    .frame(width: circleSize, height: circleSize)
                    .overlay {
                        Circle()
                            .strokeBorder(circleStrokeColor, lineWidth: 2)
                    }

                if step.state == .complete {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            .frame(height: circleSize)

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

    private var circleStrokeColor: Color {
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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var revealProgress: CGFloat = 0

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
                .opacity(reduceMotion ? 1 : revealProgress)

                Path { path in
                    guard let firstPoint = points.first else { return }
                    path.move(to: firstPoint)
                    points.dropFirst().forEach { path.addLine(to: $0) }
                }
                .trim(from: 0, to: reduceMotion ? 1 : revealProgress)
                .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))

                if let lastPoint = points.last {
                    Circle()
                        .fill(Color.primaryGreen)
                        .frame(width: 16, height: 16)
                        .overlay(Circle().stroke(Color.appWhite, lineWidth: 3))
                        .position(lastPoint)
                        .scaleEffect(reduceMotion ? 1 : 0.82 + revealProgress * 0.18)
                        .opacity(reduceMotion ? 1 : revealProgress)

                    Text("82\nMay 13")
                        .font(.appSans(size: 12, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Color.primaryGreen, in: RoundedRectangle(cornerRadius: 6))
                        .position(x: max(lastPoint.x - 8, 36), y: min(lastPoint.y + 48, geometry.size.height - 28))
                        .offset(y: reduceMotion ? 0 : 8 * (1 - revealProgress))
                        .opacity(reduceMotion ? 1 : revealProgress)
                }
            }
        }
        .onAppear {
            revealProgress = reduceMotion ? 1 : 0
            guard !reduceMotion else { return }
            withAnimation(RiadMotion.data.delay(0.08)) {
                revealProgress = 1
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
        NavigationLink(value: AppRoute.goal(goal.title)) {
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
                    MiniProgressRing(progress: goal.progress, isText: false)

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
        .buttonStyle(RiadPressStyle())
    }
}

struct MiniProgressRing: View {
    let progress: CGFloat
    let isText: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var displayedProgress: CGFloat = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.secondarySage.opacity(0.35), lineWidth: 5)

            Circle()
                .trim(from: 0, to: reduceMotion ? progress : displayedProgress)
                .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            if isText{
                Text("\(Int(progress * 100))%")
                    .font(.appSans(size: 12, weight: .bold))
                    .foregroundStyle(Color.darkText)
            }
            
        }
        .frame(width: 52, height: 52)
        .onAppear {
            displayedProgress = reduceMotion ? progress : 0
            guard !reduceMotion else { return }
            withAnimation(RiadMotion.data) {
                displayedProgress = progress
            }
        }
    }
}

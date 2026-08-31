//
//  TrackingScreen.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

struct TrackingScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 14) {
                Header(title: "Tracking")
                WeekSelector()
                HabitsCard()
                QuickLogCard()
                MoodCard()
                WeeklyConsistencyCard()
                SymptomsDigestionCard()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 104)
        }
    }
}

struct WeekSelector: View {
    private let days = [
        TrackingDay(weekday: "MON", number: "13", isSelected: false),
        TrackingDay(weekday: "TUE", number: "14", isSelected: false),
        TrackingDay(weekday: "WED", number: "15", isSelected: true),
        TrackingDay(weekday: "THU", number: "16", isSelected: false),
        TrackingDay(weekday: "FRI", number: "17", isSelected: false),

    ]

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                } label: {
                    LucideIcon(name: "chevron-left", fallbackSystemName: "chevron.left", size: 24)
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.primaryGreen)

                Spacer()

                Text("May 13-19")
                    .font(.appSans(size: 21, weight: .medium))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Button {
                } label: {
                    LucideIcon(name: "chevron-right", fallbackSystemName: "chevron.right", size: 24)
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.primaryGreen)
            }

            HStack(spacing: 10) {
                ForEach(days) { day in
                    TrackingDayChip(day: day)
                }
            }
        }
    }
}

struct TrackingDay: Identifiable {
    let id = UUID()
    let weekday: String
    let number: String
    let isSelected: Bool
}

struct TrackingDayChip: View {
    let day: TrackingDay

    var body: some View {
        VStack(spacing: 3) {
            Text(day.weekday)
                .font(.appSans(size: 11, weight: .medium))

            Text(day.number)
                .font(.appSans(size: 20, weight: .semibold))

            Text(day.isSelected ? "TODAY" : " ")
                .font(.appSans(size: 8, weight: .bold))
        }
        .foregroundStyle(day.isSelected ? Color.appWhite : Color.darkText)
        .frame(maxWidth: .infinity)
        .frame(height: 78)
        .background(day.isSelected ? Color.primaryGreen : Color.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.warmNeutralBorder.opacity(day.isSelected ? 0 : 0.8), lineWidth: 1)
        }
    }
}

struct HabitsCard: View {
    private let habits = [
        Habit(title: "Fiber", amount: "24 / 33 g", progress: 0.73, icon: "leaf", fallback: "leaf"),
        Habit(title: "Water", amount: "2.1 / 2.5 L", progress: 0.84, icon: "droplet", fallback: "drop"),
        Habit(title: "Fermented foods", amount: "1 / 2", progress: 0.50, icon: "milk", fallback: "takeoutbag.and.cup.and.straw")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Today's habits")
                .font(.appSerif(size: 25))
                .foregroundStyle(Color.darkText)

            VStack(spacing: 0) {
                ForEach(habits) { habit in
                    HabitRow(habit: habit)

                    if habit.id != habits.last?.id {
                        Divider()
                            .padding(.leading, 82)
                    }
                }
            }
        }
        .padding(18)
        .riadCard()
    }
}

struct Habit: Identifiable {
    let id = UUID()
    let title: String
    let amount: String
    let progress: CGFloat
    let icon: String
    let fallback: String
}

struct HabitRow: View {
    let habit: Habit

    var body: some View {
        HStack(spacing: 18) {
            TrackingIconBadge(icon: habit.icon, fallback: habit.fallback)

            MiniProgressRing(progress: habit.progress,isText: true)

            VStack(alignment: .leading, spacing: 4) {
                Text(habit.title)
                    .font(.appSerif(size: 23))
                    .foregroundStyle(Color.darkText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text(habit.amount)
                    .font(.appSans(size: 17))
                    .foregroundStyle(Color.mutedText)
            }

            Spacer()

            Button {
            } label: {
                LucideIcon(name: "plus", fallbackSystemName: "plus", size: 22)
                    .frame(width: 50, height: 50)
                    .background(Color.paleSage.opacity(0.75), in: RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .foregroundStyle(Color.primaryGreen)
        }
        .padding(.vertical, 10)
    }
}

struct TrackingIconBadge: View {
    let icon: String
    let fallback: String

    var body: some View {
        LucideIcon(name: icon, fallbackSystemName: fallback, size: 28)
            .foregroundStyle(Color.primaryGreen)
            .frame(width: 58, height: 58)
            .background(Color.paleSage.opacity(0.7), in: Circle())
    }
}

struct QuickLogCard: View {
    private let items = [
        QuickLogItem(title: "Meal", icon: "salad", fallback: "fork.knife"),
        QuickLogItem(title: "Water", icon: "droplet", fallback: "drop"),
        QuickLogItem(title: "Symptom", icon: "circle-frown", fallback: "face.dashed"),
        QuickLogItem(title: "Movement", icon: "person-standing", fallback: "figure.walk")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Quick log")
                .font(.appSerif(size: 25))
                .foregroundStyle(Color.darkText)

            HStack(spacing: 12) {
                ForEach(items) { item in
                    QuickLogButton(item: item)
                }
            }
        }
        .padding(18)
        .riadCard()
    }
}

struct QuickLogItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let fallback: String
}

struct QuickLogButton: View {
    let item: QuickLogItem

    var body: some View {
        Button {
        } label: {
            VStack(spacing: 8) {
                LucideIcon(name: item.icon, fallbackSystemName: item.fallback, size: 32)
                    .foregroundStyle(Color.darkText)

                Text(item.title)
                    .font(.appSans(size: 13, weight: .medium))
                    .foregroundStyle(Color.darkText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 86)
            .background(Color.paleSage.opacity(0.55), in: RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
    }
}

struct MoodCard: View {
    private let moods = [
        Mood(label: "Very low", icon: "face-angry", isSelected: false),
        Mood(label: "Low", icon: "face-expressionless", isSelected: false),
        Mood(label: "Neutral", icon: "face-neutral", isSelected: false),
        Mood(label: "Good", icon: "smile", isSelected: true),
        Mood(label: "Great", icon: "face-grinning", isSelected: false)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("How are you feeling?")
                    .font(.appSerif(size: 25))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Button {
                } label: {
                    Label {
                        Text("Add note")
                    } icon: {
                        LucideIcon(name: "pencil", fallbackSystemName: "pencil", size: 16)
                    }
                    .font(.appSans(size: 13, weight: .semibold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.primaryGreen)
            }

            HStack(spacing: 12) {
                ForEach(moods) { mood in
                    MoodOption(mood: mood)
                }
            }
        }
        .padding(18)
        .riadCard()
    }
}

struct Mood: Identifiable {
    let id = UUID()
    let label: String
    let icon: String
    let isSelected: Bool
}

struct MoodOption: View {
    let mood: Mood

    var body: some View {
        VStack(spacing: 7) {
            LucideIcon(name: mood.icon, fallbackSystemName: "face.smiling", size: 28)
                .foregroundStyle(mood.isSelected ? Color.appWhite : Color.secondarySage)
                .frame(width: 50, height: 50)
                .background(mood.isSelected ? Color.primaryGreen : Color.clear, in: Circle())
                .overlay {
                    Circle()
                        .stroke(mood.isSelected ? Color.primaryGreen : Color.secondarySage, lineWidth: 2)
                }

            Text(mood.label)
                .font(.appSans(size: 12, weight: mood.isSelected ? .semibold : .regular))
                .foregroundStyle(mood.isSelected ? Color.primaryGreen : Color.mutedText)
                .lineLimit(1)
                .minimumScaleFactor(0.65)
        }
        .frame(maxWidth: .infinity)
    }
}

struct WeeklyConsistencyCard: View {
    private let bars: [CGFloat] = [0.64, 0.61, 0.78, 0.63, 0.78, 0.69]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weekly consistency")
                .font(.appSerif(size: 25))
                .foregroundStyle(Color.darkText)

            HStack(alignment: .bottom, spacing: 18) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("86%")
                        .font(.appSerif(size: 52))
                        .foregroundStyle(Color.primaryGreen)

                    Text("consistency")
                        .font(.appSans(size: 17))
                        .foregroundStyle(Color.darkText)

                    Label("+12% from last week", systemImage: "arrow.up.right")
                        .font(.appSans(size: 14, weight: .semibold))
                        .foregroundStyle(Color.primaryGreen)
                }

                ConsistencyBarChart(values: bars, selectedIndex: 2)
                    .frame(height: 110)
            }
        }
        .padding(18)
        .riadCard()
    }
}

struct ConsistencyBarChart: View {
    let values: [CGFloat]
    let selectedIndex: Int

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(Array(values.enumerated()), id: \.offset) { index, value in
                VStack(spacing: 7) {
                    if index == selectedIndex {
                        LucideIcon(name: "star", fallbackSystemName: "star.fill", size: 13)
                            .foregroundStyle(Color.appWhite)
                            .frame(width: 22, height: 22)
                            .background(Color.primaryGreen, in: Circle())
                    } else {
                        Spacer()
                            .frame(height: 22)
                    }

                    RoundedRectangle(cornerRadius: 5)
                        .fill(index == selectedIndex ? Color.primaryGreen : Color.secondarySage.opacity(0.65))
                        .frame(width: 20, height: max(18, value * 82))

                    Text(dayLabel(for: index))
                        .font(.appSans(size: 11, weight: .medium))
                        .foregroundStyle(Color.darkText)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func dayLabel(for index: Int) -> String {
        ["M", "T", "W", "T", "F", "S"][index]
    }
}

struct SymptomsDigestionCard: View {
    private let values: [CGFloat] = [0.46, 0.12, 0.14, 0.52, 0.9, 0.56, 0.28]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Symptoms & digestion")
                    .font(.appSerif(size: 25))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Button {
                } label: {
                    Label("View history", systemImage: "chevron.right")
                        .labelStyle(.titleAndIcon)
                        .font(.appSans(size: 13, weight: .semibold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.darkText)
            }

            SymptomLineChart(values: values)
                .frame(height: 116)

            HStack(spacing: 14) {
                StatusPill(icon: "toilet", fallback: "medical.thermometer", title: "Bloating", value: "Low")
                StatusPill(icon: "zap", fallback: "bolt", title: "Energy", value: "Good")
            }
        }
        .padding(18)
        .riadCard()
    }
}

struct SymptomLineChart: View {
    let values: [CGFloat]

    var body: some View {
        GeometryReader { geometry in
            let points = values.enumerated().map { index, value in
                CGPoint(
                    x: CGFloat(index) / CGFloat(values.count - 1) * geometry.size.width,
                    y: (1 - value) * (geometry.size.height - 18) + 9
                )
            }

            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    ForEach(["High", "Medium", "Low"], id: \.self) { label in
                        HStack(spacing: 8) {
                            Text(label)
                                .font(.appSans(size: 11))
                                .foregroundStyle(Color.mutedText)
                                .frame(width: 48, alignment: .leading)

                            Divider()
                                .overlay(Color.warmNeutralBorder.opacity(0.45))
                        }
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
                .offset(x: 48)
                .fill(Color.paleSage.opacity(0.45))

                Path { path in
                    guard let firstPoint = points.first else { return }
                    path.move(to: firstPoint)
                    points.dropFirst().forEach { path.addLine(to: $0) }
                }
                .offset(x: 48)
                .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

                ForEach(Array(points.enumerated()), id: \.offset) { _, point in
                    Circle()
                        .fill(Color.primaryGreen)
                        .frame(width: 8, height: 8)
                        .position(x: point.x + 48, y: point.y)
                }
            }
            .padding(.trailing, 48)
        }
    }
}

struct StatusPill: View {
    let icon: String
    let fallback: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 10) {
            LucideIcon(name: icon, fallbackSystemName: fallback, size: 24)
                .foregroundStyle(Color.primaryGreen)

            Text(title + ": ")
                .font(.appSans(size: 16))
                .foregroundStyle(Color.darkText)
            + Text(value)
                .font(.appSans(size: 16, weight: .semibold))
                .foregroundStyle(Color.primaryGreen)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.paleSage.opacity(0.65), in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    TrackingScreen()
        .background(Color.creamBackground)
}

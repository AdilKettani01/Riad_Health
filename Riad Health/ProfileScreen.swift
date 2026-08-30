//
//  ProfileScreen.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Header(title: "Profile")
                ProfileIdentityCard()
                JourneyCard()
                ProfileGoalsSection()
                MembershipCard()
                HealthPreferencesSection()
                PrivacyRow()
                SupportSection()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 104)
        }
    }
}

struct ProfileIdentityCard: View {
    var body: some View {
        HStack(spacing: 22) {
            Image("pfp")
                .resizable()
                .scaledToFill()
                .frame(width: 122, height: 122)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 10) {
                Text("Alex Morgan")
                    .font(.appSerif(size: 37))
                    .foregroundStyle(Color.darkText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)

                Text("Member since Apr 2026")
                    .font(.appSans(size: 18))
                    .foregroundStyle(Color.mutedText)

                Button {
                } label: {
                    Text("Edit profile")
                        .font(.appSans(size: 16, weight: .medium))
                        .foregroundStyle(Color.primaryGreen)
                        .padding(.horizontal, 22)
                        .frame(height: 44)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.primaryGreen, lineWidth: 1.2)
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct JourneyCard: View {
    private let stats = [
        JourneyStat(value: "42", label: "Days"),
        JourneyStat(value: "82", label: "Score"),
        JourneyStat(value: "6", label: "Day streak")
    ]

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 18) {
                Text("Your journey")
                    .font(.appSerif(size: 28))
                    .foregroundStyle(Color.darkText)

                HStack(spacing: 0) {
                    ForEach(stats) { stat in
                        JourneyStatView(stat: stat)

                        if stat.id != stats.last?.id {
                            Divider()
                                .frame(height: 56)
                        }
                    }
                }
            }

            LeafAccent()
                .stroke(Color.secondarySage.opacity(0.62), lineWidth: 1.4)
                .frame(width: 58, height: 70)
                .padding(.trailing, 18)
                .padding(.top, 18)
        }
        .padding(22)
        .background(Color.paleSage.opacity(0.65), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.warmNeutralBorder.opacity(0.4), lineWidth: 1)
        }
    }
}

struct JourneyStat: Identifiable {
    let id = UUID()
    let value: String
    let label: String
}

struct JourneyStatView: View {
    let stat: JourneyStat

    var body: some View {
        VStack(spacing: 4) {
            Text(stat.value)
                .font(.appSerif(size: 40))
                .foregroundStyle(Color.primaryGreen)

            Text(stat.label)
                .font(.appSans(size: 17))
                .foregroundStyle(Color.mutedText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileGoalsSection: View {
    private let goals = [
        ProfileGoal(title: "Daily balance", icon: "leaf", fallback: "leaf", isSelected: true),
        ProfileGoal(title: "More energy", icon: "zap", fallback: "bolt", isSelected: false),
        ProfileGoal(title: "Better digestion", icon: "worm", fallback: "waveform.path.ecg", isSelected: false)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Your goals")
                    .font(.appSerif(size: 26))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Button {
                } label: {
                    Text("Edit goals")
                        .font(.appSans(size: 15, weight: .medium))
                        .underline()
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.primaryGreen)
            }

            HStack(spacing: 10) {
                ForEach(goals) { goal in
                    ProfileGoalChip(goal: goal)
                }
            }
        }
    }
}

struct ProfileGoal: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let fallback: String
    let isSelected: Bool
}

struct ProfileGoalChip: View {
    let goal: ProfileGoal

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 8) {
                LucideIcon(name: goal.icon, fallbackSystemName: goal.fallback, size: 18)

                Text(goal.title)
                    .font(.appSans(size: 14, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)
            }
            .foregroundStyle(goal.isSelected ? Color.appWhite : Color.darkText)
            .padding(.horizontal, 18)
            .frame(height: 54)
            .background(goal.isSelected ? Color.primaryGreen : Color.appWhite)
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(goal.isSelected ? Color.primaryGreen : Color.warmNeutralBorder, lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

struct MembershipCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Your membership")
                .font(.appSerif(size: 26))
                .foregroundStyle(Color.darkText)

            HStack(spacing: 22) {
                ProductBottle(tint: .primaryGreen)
                    .scaleEffect(1.05)
                    .frame(width: 112, height: 128)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Daily Synbiotic")
                        .font(.appSerif(size: 27))
                        .foregroundStyle(Color.darkText)

                    Text("Next shipment in 5 days")
                        .font(.appSans(size: 17))
                        .foregroundStyle(Color.primaryGreen)

                    Divider()
                        .padding(.vertical, 6)

                    Button {
                    } label: {
                        HStack {
                            Text("Manage plan")
                                .font(.appSans(size: 16, weight: .medium))

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.appSans(size: 13, weight: .semibold))
                        }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(Color.darkText)
                }
            }
        }
        .padding(20)
        .riadCard()
    }
}

struct HealthPreferencesSection: View {
    private let items = [
        ProfileListItem(title: "Dietary preferences", value: "Vegetarian", icon: "leaf", fallback: "leaf"),
        ProfileListItem(title: "Reminders", value: "8:00 AM", icon: "bell", fallback: "bell"),
        ProfileListItem(title: "Connected apps", value: "Apple Health", icon: "heart", fallback: "heart")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Health preferences")
                .font(.appSerif(size: 26))
                .foregroundStyle(Color.darkText)

            VStack(spacing: 0) {
                ForEach(items) { item in
                    ProfileListRow(item: item)

                    if item.id != items.last?.id {
                        Divider()
                            .padding(.leading, 70)
                    }
                }
            }
            .riadCard()
        }
    }
}

struct ProfileListItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
    let fallback: String
}

struct ProfileListRow: View {
    let item: ProfileListItem

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 16) {
                LucideIcon(name: item.icon, fallbackSystemName: item.fallback, size: 21)
                    .foregroundStyle(Color.primaryGreen)
                    .frame(width: 42, height: 42)
                    .background(Color.paleSage.opacity(0.7), in: RoundedRectangle(cornerRadius: 8))

                Text(item.title)
                    .font(.appSans(size: 16, weight: .medium))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Text(item.value)
                    .font(.appSans(size: 15))
                    .foregroundStyle(Color.mutedText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Image(systemName: "chevron.right")
                    .font(.appSans(size: 12, weight: .semibold))
                    .foregroundStyle(Color.primaryGreen)
            }
            .padding(.horizontal, 18)
            .frame(height: 64)
        }
        .buttonStyle(.plain)
    }
}

struct PrivacyRow: View {
    var body: some View {
        ProfileListRow(
            item: ProfileListItem(
                title: "Your data & privacy",
                value: "",
                icon: "lock-keyhole",
                fallback: "lock"
            )
        )
        .riadCard()
    }
}

struct SupportSection: View {
    private let items = [
        ProfileListItem(title: "Help center", value: "", icon: "circle-help", fallback: "questionmark.circle"),
        ProfileListItem(title: "Contact support", value: "", icon: "headphones", fallback: "headphones")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Support")
                .font(.appSerif(size: 26))
                .foregroundStyle(Color.darkText)

            VStack(spacing: 0) {
                ForEach(items) { item in
                    ProfileListRow(item: item)

                    if item.id != items.last?.id {
                        Divider()
                            .padding(.leading, 70)
                    }
                }
            }
            .riadCard()
        }
    }
}

#Preview {
    ProfileScreen()
        .background(Color.creamBackground)
}

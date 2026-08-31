//
//  ShopScreen.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

struct ShopScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Header(title: "Shop")

                VStack(alignment: .leading, spacing: 4) {
                    Text("Your daily routine")
                        .font(.appSerif(size: 30))
                        .foregroundStyle(Color.darkText)

                    Text("Science-backed support for your gut.")
                        .font(.appSans(size: 18))
                        .foregroundStyle(Color.mutedText)
                }

                PlanCard()
                RecommendedProductsSection()
                ShopInsightBanner()
                GoalCategorySection()
                ShopBenefitsCard()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 104)
        }
    }
}

struct PlanCard: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 9) {
                Text("YOUR PLAN")
                    .font(.appSans(size: 14, weight: .semibold))
                    .foregroundStyle(Color.secondarySage)

                Text("Daily Synbiotic")
                    .font(.appSerif(size: 30))
                    .foregroundStyle(Color.primaryGreen)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text("Renews Jun 1")
                    .font(.appSans(size: 14))
                    .foregroundStyle(Color.mutedText)

                Button {
                } label: {
                    Text("Manage plan")
                        .font(.appSans(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 52)
                        .background(Color.primaryGreen, in: RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)

                Label {
                    Text("Arrives in 5 days")
                        .font(.appSans(size: 13, weight: .semibold))
                        .lineLimit(1)
                            
                        .frame(alignment: .leading)
                } icon: {
                    LucideIcon(name: "truck", fallbackSystemName: "truck.box", size: 20)
                }
                .foregroundStyle(Color.primaryGreen)
            }

            Spacer(minLength: 6)

            ZStack(alignment: .trailing) {
                Image("olive_leaf").resizable().scaledToFit().frame(width: 158, height: 158).scaleEffect(x:-1, y:1)

                Image("pill_box_3").resizable().scaledToFit().frame(width: 158, height: 158)
            }
            .frame(width: 150, height: 190)
        }
        .padding(22)
        .riadCard()
    }
}

struct RecommendedProductsSection: View {
    private let products = [
        ShopProduct(
            name: "Daily Synbiotic",
            description: "Daily gut & immune balance support",
            price: "$49.00",
            tint: .primaryGreen,
            accent: .leaf,
            imgName: "img1"
        ),
        ShopProduct(
            name: "Fiber + Prebiotic",
            description: "Supports regularity & digestive comfort",
            price: "$39.00",
            tint: .primaryGreen,
            accent: .scoop,
            imgName: "img2"
        ),
        ShopProduct(
            name: "Travel Pack",
            description: "Stay consistent, wherever you go",
            price: "$19.00",
            tint: .secondarySage,
            accent: .pack,
            imgName: "img3"
        )
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recommended for you")
                    .font(.appSerif(size: 24))
                    .foregroundStyle(Color.darkText)

                Spacer()

                Button {
                } label: {
                    Label("See all", systemImage: "chevron.right")
                        .labelStyle(.titleAndIcon)
                        .font(.appSans(size: 15, weight: .medium))
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.darkText)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(products) { product in
                        ShopProductCard(product: product)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

struct ShopProduct: Identifiable {
    enum Accent {
        case leaf
        case scoop
        case pack
    }

    let id = UUID()
    let name: String
    let description: String
    let price: String
    let tint: Color
    let accent: Accent
    let imgName: String
}

struct ShopProductCard: View {
    let product: ShopProduct

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Image(product.imgName).resizable().scaledToFit().frame(maxWidth:.infinity, maxHeight: .infinity)
                .frame(maxWidth: .infinity, alignment: .center)
        
    
            

            Text(product.name)
                .font(.appSerif(size: 20))
                .foregroundStyle(Color.darkText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(product.description)
                .font(.appSans(size: 14))
                .foregroundStyle(Color.mutedText)
                .lineLimit(2)
                .frame(height: 38, alignment: .topLeading)

            HStack(alignment: .bottom) {
                Text(product.price)
                    .font(.appSans(size: 18, weight: .bold))
                    .foregroundStyle(Color.primaryGreen)

                Spacer()

                Button {
                } label: {
                    LucideIcon(name: "plus", fallbackSystemName: "plus", size: 22)
                        .frame(width: 38, height: 38)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.primaryGreen, lineWidth: 1.2)
                        }
                }
                .buttonStyle(.plain)
                .foregroundStyle(Color.primaryGreen)
            }
        }
        .padding(14)
        .frame(width: 180, height: 320)
        .riadCard()
    }
}

struct ProductPouch: View {
    let tint: Color

    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(tint.opacity(0.88))
                .frame(width: 78, height: 16)

            RoundedRectangle(cornerRadius: 7)
                .fill(tint.gradient)
                .frame(width: 86, height: 118)
                .overlay {
                    VStack(spacing: 10) {
                        Text("RIAD\nHEALTH")
                            .font(.appSans(size: 7, weight: .bold))
                            .multilineTextAlignment(.center)

                        Text("M")
                            .font(.appSerif(size: 34))

                        Text("TRAVEL\nPACK")
                            .font(.appSans(size: 8, weight: .bold))
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.white)
                }
        }
    }
}

struct ShopInsightBanner: View {
    var body: some View {
        HStack(spacing: 18) {
            LucideIcon(name: "shield", fallbackSystemName: "shield", size: 34)
                .foregroundStyle(Color.primaryGreen)

            VStack(alignment: .leading, spacing: 4) {
                Text("Build a resilient routine")
                    .font(.appSerif(size: 14))
                    .lineLimit(1)
                    .foregroundStyle(Color.darkText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Small daily choices add up to lasting balance and better days.")
                    .font(.appSans(size: 9))
                    .foregroundStyle(Color.mutedText)
                    .lineLimit(2)
            }

            Spacer()

            Button {
            } label: {
                Label("Learn more", systemImage: "chevron.right")
                    .labelStyle(.titleAndIcon)
                    .font(.appSans(size: 14, weight: .semibold))
            }
            .buttonStyle(.plain)
            .foregroundStyle(Color.primaryGreen)
        }
        .padding(18)
        .background(Color.paleSage.opacity(0.65), in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.warmNeutralBorder.opacity(0.45), lineWidth: 1)
        }
    }
}

struct GoalCategorySection: View {
    private let goals = [
        GoalCategory(title: "Daily balance", icon: "sprout", fallback: "leaf"),
        GoalCategory(title: "Better digestion", icon: "chart-spline", fallback: "waveform.path.ecg"),
        GoalCategory(title: "On the go", icon: "luggage", fallback: "suitcase")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Explore by goal")
                .font(.appSerif(size: 24))
                .foregroundStyle(Color.darkText)

            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 12){
                    ForEach(goals){ goal in GoalCategoryCard(goal: goal).frame(width: 180)
                    }
                }.padding(.vertical, 2)
            }
        }
    }
}

struct GoalCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let fallback: String
}

struct GoalCategoryCard: View {
    let goal: GoalCategory

    var body: some View {
        Button {
        } label: {
            HStack(spacing: 9) {
                LucideIcon(name: goal.icon, fallbackSystemName: goal.fallback, size: 28)
                    .foregroundStyle(Color.primaryGreen)
                    .frame(width: 44, height: 44)
                    .overlay(Circle().stroke(Color.secondarySage, lineWidth: 1.3))

                Text(goal.title)
                    .font(.appSans(size: 13, weight: .medium))
                    .foregroundStyle(Color.darkText)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.appSans(size: 12, weight: .semibold))
                    .foregroundStyle(Color.darkText)
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .riadCard()
        }
        .buttonStyle(.plain)
    }
}

struct ShopBenefitsCard: View {
    private let benefits = [
        ShopBenefit(title: "Thoughtfully formulated", icon: "leaf", fallback: "leaf"),
        ShopBenefit(title: "Delivered on your schedule", icon: "calendar-check", fallback: "calendar.badge.checkmark"),
        ShopBenefit(title: "Easy to pause", icon: "pause", fallback: "pause")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Why Riad Health")
                .font(.appSerif(size: 24))
                .foregroundStyle(Color.darkText)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 12) {
                    ForEach(benefits) { benefit in
                        ShopBenefitView(benefit: benefit)

                        if benefit.id != benefits.last?.id {
                            Divider()
                                .padding(.vertical, 6)
                        }
                    }
                }
            }.padding(.vertical, 2)
            
        }
        .padding(18)
        .riadCard()
    }
}

struct ShopBenefit: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let fallback: String
}

struct ShopBenefitView: View {
    let benefit: ShopBenefit

    var body: some View {
        HStack(spacing: 8) {
            LucideIcon(name: benefit.icon, fallbackSystemName: benefit.fallback, size: 22)
                .foregroundStyle(Color.primaryGreen)
                .frame(width: 38, height: 38)
                .overlay(Circle().stroke(Color.secondarySage.opacity(0.9), lineWidth: 1.2))

            Text(benefit.title)
                .font(.appSans(size: 12, weight: .medium))
                .foregroundStyle(Color.darkText)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}

struct LeafAccent: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerX = rect.midX

        path.move(to: CGPoint(x: centerX, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: centerX, y: rect.minY),
            control1: CGPoint(x: rect.minX + rect.width * 0.24, y: rect.maxY * 0.72),
            control2: CGPoint(x: rect.maxX - rect.width * 0.2, y: rect.maxY * 0.32)
        )

        for index in 0..<6 {
            let progress = CGFloat(index) / 5
            let y = rect.maxY - progress * rect.height * 0.78 - rect.height * 0.12
            let side = index.isMultiple(of: 2) ? -1.0 : 1.0
            path.move(to: CGPoint(x: centerX, y: y))
            path.addQuadCurve(
                to: CGPoint(x: centerX + side * rect.width * 0.38, y: y - rect.height * 0.11),
                control: CGPoint(x: centerX + side * rect.width * 0.2, y: y - rect.height * 0.22)
            )
        }

        return path
    }
}

#Preview {
    ShopScreen()
        .background(Color.creamBackground)
}

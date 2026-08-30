//
//  HomeComponents.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI
import LucideIcons

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

struct GreetingView: View {
    let name: String
    let day: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Good morning, \(name)")
                .font(.appSerif(size: 40))
                .foregroundStyle(Color.darkText)

            Text("Day \(day) of your gut health journey.")
                .font(.appSans(size: 18))
                .foregroundStyle(Color.mutedText)
        }
    }
}

struct HealthMetric {
    let title: String
    let value: String
    let icon: String
}

struct HealthScoreSummary: View {
    let score: Int
    let leftMetric: HealthMetric
    let rightMetric: HealthMetric

    var body: some View {
        HStack(spacing: 14) {
            MetricCard(metric: leftMetric)
            ScoreRing(score: score)
            MetricCard(metric: rightMetric)
        }
    }
}
struct MetricCard: View {
    let metric: HealthMetric

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 5) {
                LucideIconImage(id: metric.icon, fallbackSystemImage: metric.icon)
                    .frame(width: 14, height: 14)

                Text(metric.title)
                    .font(.appSans(size: 13, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundStyle(Color.darkText)

            Text(metric.value)
                .font(.appSans(size: 18, weight: .bold))
                .foregroundStyle(Color.primaryGreen)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 78)
        .riadCard()
    }
}

struct LucideIconImage: View {
    let id: String
    let fallbackSystemImage: String

    var body: some View {
        #if canImport(UIKit)
        if let image = UIImage(lucideId: id) {
            Image(uiImage: image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: fallbackSystemImage)
                .resizable()
                .scaledToFit()
        }
        #elseif canImport(AppKit)
        if let image = NSImage.image(lucideId: id) {
            Image(nsImage: image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: fallbackSystemImage)
                .resizable()
                .scaledToFit()
        }
        #else
        Image(systemName: fallbackSystemImage)
            .resizable()
            .scaledToFit()
        #endif
    }
}

struct ScoreRing: View {
    let score: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.secondarySage.opacity(0.35), lineWidth: 12)

            Circle()
                .trim(from: 0, to: CGFloat(score) / 100)
                .stroke(
                    Color.primaryGreen,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            VStack(spacing: -2) {
                Text("\(score)")
                    .font(.appSerif(size: 58))
                    .foregroundStyle(Color.darkText)

                Text("/100")
                    .font(.appSans(size: 18))
                    .foregroundStyle(Color.darkText)
            }
        }
        .frame(width: 136, height: 136)
    }
}

struct ProductCarousel: View {
    private let products = [
        Product(name: "DS-01 Daily Synbiotic", tint: .primaryGreen, showsAction: true),
        Product(name: "PDS-08 Pediatric", tint: .secondarySage, showsAction: false)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(products) { product in
                    ProductCard(product: product)
                }
            }
            .padding(.vertical, 2)
        }
    }
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let tint: Color
    let showsAction: Bool
}

struct ProductCard: View {
    let product: Product

    var body: some View {
        HStack(spacing: 14) {
            ProductBottle(tint: product.tint)

            VStack(alignment: .leading, spacing: 16) {
                Text(product.name)
                    .font(.appSerif(size: 21))
                    .foregroundStyle(Color.darkText)
                    .lineLimit(2)

                if product.showsAction {
                    Button {
                    } label: {
                        Label("Mark as taken", systemImage: "checkmark.circle.fill")
                            .font(.appSans(size: 15, weight: .medium))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(Color.primaryGreen)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color.paleSage.opacity(0.7), in: RoundedRectangle(cornerRadius: 8))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.appSans(size: 18, weight: .semibold))
                        .foregroundStyle(Color.darkText)
                        .frame(width: 38, height: 38)
                        .background(Color.appWhite, in: Circle())
                        .overlay(Circle().stroke(Color.warmNeutralBorder, lineWidth: 1))
                }
            }
        }
        .padding(14)
        .frame(width: product.showsAction ? 300 : 190, height: 150)
        .riadCard()
    }
}

struct ProductBottle: View {
    let tint: Color

    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.black.opacity(0.2))
                .frame(width: 60, height: 14)

            RoundedRectangle(cornerRadius: 6)
                .fill(tint.gradient)
                .frame(width: 70, height: 104)
                .overlay {
                    VStack(spacing: 18) {
                        Text("Seed")
                            .font(.appSans(size: 8, weight: .bold))
                            .foregroundStyle(.white)

                        Circle()
                            .fill(.white)
                            .frame(width: 6, height: 6)

                        Text("Daily")
                            .font(.appSans(size: 7, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 10)
                }
        }
    }
}

struct InsightBanner: View {
    let message: String

    var body: some View {
        HStack(spacing: 12) {
            LucideIconImage(id: "trending-up", fallbackSystemImage: "arrow.up.right")
                .frame(width: 14, height: 14)

            Text(message)
                .font(.appSans(size: 17))
                .foregroundStyle(Color.darkText)
                .lineLimit(2)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.appSans(size: 15, weight: .semibold))
                .foregroundStyle(Color.primaryGreen)
        }
        .padding(16)
        .background(Color.paleSage.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.warmNeutralBorder.opacity(0.45), lineWidth: 1)
        }
    }
}

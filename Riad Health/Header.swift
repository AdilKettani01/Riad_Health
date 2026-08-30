//
//  Header.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

public struct Header: View {
    let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        HStack {
            Image("logo_polished_light")
                .resizable()
                .scaledToFit()
                .frame(width: 58, height: 58)

            Spacer()

            Text(title)
                .font(.appSerif(size: 32))
                .foregroundStyle(Color.primaryGreen)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Spacer()

            ProfileAvatar(streakCount: 14)
        }
    }
}

struct ProfileAvatar: View {
    let streakCount: Int?

    init(streakCount: Int? = nil) {
        self.streakCount = streakCount
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("pfp")
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .clipShape(Circle())

            if let streakCount {
                Text("\(streakCount)")
                    .font(.appSans(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(Color.primaryGreen, in: Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.creamBackground, lineWidth: 2)
                    )
            }
        }
        .frame(width: 56, height: 56)
    }
}

#Preview {
    VStack(spacing: 24) {
        Header(title: "Riad Health")
        Header(title: "Tracking")
        Header(title: "Shop")
        Header(title: "Profile")
    }
    .padding()
    .background(Color.creamBackground)
}

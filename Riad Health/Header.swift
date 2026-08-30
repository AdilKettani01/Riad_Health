//
//  Header.swift
//  Riad Health
//
//  Created by Adil Kettani on 30/8/2026.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Image("logo_polished_light")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

            Spacer()

            Text("Seed")
                .font(.appSerif(size: 44))
                .foregroundStyle(Color.primaryGreen)

            Spacer()

            ProfileAvatar(streakCount: 14)
        }
    }
}

struct ProfileAvatar: View {
    let streakCount: Int

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("pfp")
                .resizable()
                .scaledToFill()
                .frame(width: 52, height: 52)
                .clipShape(Circle())

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
        .frame(width: 56, height: 56)
    }
}

#Preview {
    Header()
        .padding()
        .background(Color.creamBackground)
}

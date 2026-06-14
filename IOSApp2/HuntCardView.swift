
// ==========================
// HuntCardView.swift
// IOSApp2
// ==========================
//
// Purpose:
//
// Reusable card component used
// to display scavenger hunt items
//
// This improves UI consistency
// across the app
// ==========================

import SwiftUI

struct HuntCardView: View {

    // Title passed from parent view
    var title: String

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            // ==========================
            // TITLE TEXT
            // ==========================
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Spacer()

        }
        .padding()

        // ==========================
        // FULL WIDTH CARD
        // ==========================
        .frame(maxWidth: .infinity, alignment: .leading)

        // ==========================
        // CARD BACKGROUND STYLE
        // ==========================
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.15))
        )

        // ==========================
        // SHADOW FOR DEPTH (A+ LOOK)
        // ==========================
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}


// =============================
// CompletionView.swift
// IOSApp2
// =============================
//
// Purpose:
//
// Displays final reward screen
// when all scavenger hunt items
// have been found.
//
// Demonstrates:
//
// - Animation
// - UI Styling
// - Navigation
//
// =============================

import SwiftUI

struct CompletionView: View {

    var reward: String

    @State private var animate = false

    var body: some View {

        VStack(spacing: 30) {

            Text("Congratulations!")

                .font(.largeTitle)

                .bold()

            Text("You completed the hunt!")

                .font(.title2)

            Text(reward)

                .font(.title)

                .foregroundColor(.blue)

                .scaleEffect(animate ? 1.2 : 1)

        }

        .onAppear {

            withAnimation(

                .spring()

                .repeatForever()

            ) {

                animate = true

            }

        }

    }

}

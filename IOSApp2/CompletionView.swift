
// =============================
// CompletionView.swift
// IOSApp2
// =============================
//
// Purpose:
//
// This screen is shown when the user
// completes the scavenger hunt.
// It displays a congratulatory message
// and a reward with a simple animation.
//
// =============================

// Import SwiftUI framework for building UI
import SwiftUI

// This struct defines a new screen (View) in the app
struct CompletionView: View {

    // ===================================================
    // This variable holds the reward text passed from previous screen
    // Example: "You earned a Gold Badge!"
    // ===================================================
    var reward: String

    // State variable used to control animation
    // When it changes, the UI automatically updates
    @State private var animate = false

    // The body defines what appears on the screen
    var body: some View {

        // VStack arranges elements vertically (top to bottom)
        VStack(spacing: 30) {

            // Main title text shown at the top
            Text("Congratulations!")
                .font(.largeTitle)   // Makes text large
                .bold()              // Makes text bold

            // Subtitle message
            Text("You completed the hunt!")
                .font(.title2)       // Medium-large font size

            // Reward text passed into this view
            Text(reward)
                .font(.title)        // Large font for emphasis
                .foregroundColor(.blue) // Makes reward text blue

                // Applies scaling animation effect
                // If animate = true → size becomes 1.2x bigger
                // If animate = false → normal size
                .scaleEffect(animate ? 1.2 : 1)

        }

        // This modifier runs when the view appears on screen
        .onAppear {

            // Starts an animation when the view loads
            withAnimation(

                // Spring animation gives a bouncy effect
                .spring()

                // Repeats animation forever (pulsing effect)
                .repeatForever()

            ) {
                // Changing this value triggers the animation
                animate = true
            }
        }
    }
}

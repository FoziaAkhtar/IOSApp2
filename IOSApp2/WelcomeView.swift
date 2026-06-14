
// =============================
// WelcomeView.swift
// IOSApp2
// Assignment 4
// =============================
//
// PURPOSE:
//
// This is the first screen of the app.
// It introduces the Scavenger Hunt game
// and provides a clear start button.
//
// The user cannot play the game until
// they press "Start Hunt".
//
// =============================

import SwiftUI

struct WelcomeView: View {

    // ==========================================
    // STATE VARIABLE: Animation Control
    //
    // This controls whether the title and icon
    // are animating (pulsing effect).
    //
    // When true → animation runs continuously
    // ==========================================
    
    @State private var animateTitle = false

    var body: some View {

        // NavigationStack enables navigation
        // from WelcomeView → ContentView
        NavigationStack {

            VStack(spacing: 25) {

                Spacer().frame(height: 20)

                // ==========================================
                // TOP ICON (APP BRANDING)
                //
                // Displays a map icon to represent
                // exploration and scavenger hunting
                // ==========================================
                
                Image(systemName: "map.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white.opacity(0.9))

                    // Applies pulsing animation
                    .scaleEffect(animateTitle ? 1.05 : 1)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                        value: animateTitle
                    )

                // ==========================================
                // APP TITLE
                //
                // Main heading shown on welcome screen
                // ==========================================
                
                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                    // Same animation as icon
                    .scaleEffect(animateTitle ? 1.05 : 1)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                        value: animateTitle
                    )

                // ==========================================
                // SUBTITLE / GREETING MESSAGE
                //
                // Welcomes the user to the app
                // ==========================================
                
                Text("Welcome, Explorer!")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))

                    // Starts animation when view appears
                    .onAppear {
                        animateTitle = true
                    }

                // ==========================================
                // HOW IT WORKS SECTION
                //
                // Explains game steps to the user
                // Improves usability and clarity
                // ==========================================
                
                VStack(alignment: .leading, spacing: 12) {

                    Text("How it works:")
                        .font(.headline)
                        .foregroundColor(.white)

                    HStack {
                        Text("🔍")
                        Text("Find hidden items")
                            .foregroundColor(.white.opacity(0.9))
                    }

                    HStack {
                        Text("📸")
                        Text("Mark them as found")
                            .foregroundColor(.white.opacity(0.9))
                    }

                    HStack {
                        Text("🏆")
                        Text("Unlock your reward")
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

                // Light card-style background for readability
                .background(Color.white.opacity(0.15))
                .cornerRadius(12)
                .padding(.horizontal)

                // ==========================================
                // GAME INFO TEXT
                //
                // Gives user quick overview of game size
                // ==========================================
                
                Text("10 items • 1 reward • Endless fun")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))

                // ==========================================
                // START BUTTON
                //
                // This navigates user into main game screen
                // (ContentView)
                // ==========================================
                
                NavigationLink {

                    ContentView()

                } label: {

                    Text("Start Hunt 🚀")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)

                // ==========================================
                // FOOTER MESSAGE
                //
                // Small instruction text for user guidance
                // ==========================================
                
                Text("Tap start when you're ready to begin your adventure")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()
            }

            // ==========================================
            // BACKGROUND GRADIENT
            //
            // Creates visually appealing background
            // and improves UI quality
            // ==========================================
            
            .background(
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.9),
                        Color.purple.opacity(0.9)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
}

// =============================
// PREVIEW
// =============================

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

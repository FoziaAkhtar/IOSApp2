
// =============================
// WelcomeView.swift
// IOSApp2
// Assignment 4
// =============================
// ============================
// FEATURES:
// • App title with animation
// • Short instructions
// • Start button
// • Navigation to ContentView
// • Gradient background for UI polish
//
// =============================

import SwiftUI

struct WelcomeView: View {

    // ==========================================
    // STATE: Controls simple title animation
    //
    // When set to true, the title gently pulses
    // to make the screen more engaging
    // ==========================================
    
    @State private var animateTitle = false

    var body: some View {

        NavigationStack {

            VStack(spacing: 25) {

                Spacer()

                // ==========================================
                // APP TITLE
                //
                // This is the main heading of the app
                // Includes a simple pulse animation
                // ==========================================
                
                Text("🎯 Scavenger Hunt")
                    .font(.largeTitle)
                    .bold()
                    .scaleEffect(animateTitle ? 1.05 : 1)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                        value: animateTitle
                    )
                    .onAppear {
                        animateTitle = true
                    }

                // ==========================================
                // DESCRIPTION TEXT
                //
                // Explains the purpose of the app
                // Helps user understand what to do
                // ==========================================
                
                Text("Find all hidden items, complete challenges, and unlock your reward!")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // ==========================================
                // START BUTTON
                //
                // Navigates user to main ContentView
                // This begins the scavenger hunt game
                // ==========================================
                
                NavigationLink {

                    ContentView()

                } label: {

                    Text("Start Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)

                Spacer()
            }

            // ==========================================
            // BACKGROUND DESIGN
            //
            // Gradient improves visual appeal
            // Makes screen look like a real app UI
            // ==========================================
            
            .background(
                LinearGradient(
                    colors: [
                        .blue.opacity(0.8),
                        .purple.opacity(0.8)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
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

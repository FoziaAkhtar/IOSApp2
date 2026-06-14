
// =============================
// DetailView.swift
// IOSApp2
// Assignment 4 
// =============================
//
// PURPOSE:
//
// This screen shows detailed information about a scavenger hunt item.
//
// The user can:
// • Read the clue
// • View the main image
// • Mark the item as found
// • Select a "found photo"
// • Use pinch-to-zoom gesture
// • See animations and visual feedback
//
// =============================

import SwiftUI

struct DetailView: View {

    // ==========================================
    // Binding from ContentView
    // Updates main list automatically
    // ==========================================
    @Binding var item: ScavengerItem

    // ==========================================
    // Controls image selection sheet
    // ==========================================
    @State private var showChoices = false

    // ==========================================
    // Stores selected image
    // ==========================================
    @State private var foundImage = ""

    // ==========================================
    // Zoom gesture scale
    // ==========================================
    @State private var scale: CGFloat = 1.0

    // ==========================================
    // Animation control
    // ==========================================
    @State private var animate = false

    // ==========================================
    // NEW: feedback message (correct / wrong)
    // ==========================================
    @State private var message = ""

    // ==========================================
    // Correct answer for this item
    // (For full project, you can replace this
    // with item.imageName for better logic)
    // ==========================================
    let correctAnswer = "coffee"

    // ==========================================
    // Available images
    // ==========================================
    let imageChoices = [
        "coffee",
        "restaurant",
        "library",
        "park",
        "gym",
        "bakery",
        "movie",
        "bookstore",
        "pharmacy",
        "grocery"
    ]

    var body: some View {

        ScrollView {

            VStack(spacing: 25) {

                // ==========================
                // TITLE
                // ==========================
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.top)

                // ==========================
                // CLUE
                // ==========================
                Text(item.clue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // ==========================
                // MAIN IMAGE
                // ==========================
                Image("combo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    .scaleEffect(scale * (animate ? 1.02 : 1))
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                    )
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                        ) {
                            animate = true
                        }
                    }

                // ==========================
                // TOGGLE FOUND
                // ==========================
                Toggle("Mark As Found", isOn: $item.found)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                // ==========================
                // SELECT IMAGE BUTTON
                // ==========================
                Button {
                    showChoices = true
                } label: {
                    Label("Select Found Photo", systemImage: "photo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                // ==========================
                // FOUND IMAGE DISPLAY
                // ==========================
                if foundImage != "" {

                    Divider()

                    Text("Found Photo")
                        .font(.headline)

                    Image(foundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 4)
                        )
                        .shadow(radius: 8)

                    Text("Great job! Item Found!")
                        .foregroundColor(.green)
                        .bold()
                }

                // ==========================
                // NEW: FEEDBACK MESSAGE
                // ==========================
                if message != "" {

                    Text(message)
                        .font(.headline)
                        .padding()
                        .foregroundColor(
                            message.contains("Correct") ? .green : .red
                        )
                }

                Spacer()
            }
            .padding()
        }

        // ==========================
        // IMAGE SELECTION SHEET
        // ==========================
        .sheet(isPresented: $showChoices) {

            NavigationView {

                ScrollView {

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 20
                    ) {

                        ForEach(imageChoices, id: \.self) { image in

                            VStack {

                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)

                                Text(image)
                                    .font(.caption)
                            }

                            // ==========================
                            // NEW LOGIC: CHECK CORRECT/WRONG
                            // ==========================
                            .onTapGesture {

                                if image == correctAnswer {

                                    // Correct selection
                                    foundImage = image
                                    item.found = true
                                    message = "✅ Correct item found!"

                                } else {

                                    // Wrong selection
                                    message = "❌ Wrong item, try again!"
                                }

                                showChoices = false
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Choose Found Item")
            }
        }
    }
}

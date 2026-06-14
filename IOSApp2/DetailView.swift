
// =============================
// DetailView.swift
// IOSApp2
// Assignment 4
// =============================
//
// Purpose:
//
// This screen shows detailed information
// about a selected scavenger hunt item.
//
// The user can:
// • Read the clue
// • View the item image
// • Mark the item as found
// • Select a "found photo"
// • Zoom the main image
// • See animations and UI effects
//
// =============================

import SwiftUI   // Import SwiftUI framework

// This view receives a scavenger item from ContentView
struct DetailView: View {

    // ==========================================
    // Binding connects this item to ContentView
    // Changes here update the main list
    // ==========================================
    @Binding var item: ScavengerItem

    // ==========================================
    // Controls whether image selection sheet shows
    // ==========================================
    @State private var showChoices = false

    // ==========================================
    // Stores the image selected by the user
    // Example: "coffee", "park", etc.
    // ==========================================
    @State private var foundImage = ""

    // ==========================================
    // Used for zoom gesture on main image
    // ==========================================
    @State private var scale: CGFloat = 1.0

    // ==========================================
    // Controls simple pulsing animation
    // ==========================================
    @State private var animate = false

    // ==========================================
    // List of available images user can choose
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

    // ==========================================
    // MAIN UI
    // ==========================================
    var body: some View {

        ScrollView {

            VStack(spacing: 25) {

                // ==========================
                // ITEM TITLE
                // ==========================
                Text(item.title)
                    .font(.largeTitle)     // Big title
                    .bold()                // Make text bold
                    .foregroundColor(.blue)
                    .padding(.top)

                // ==========================
                // ITEM CLUE TEXT
                // ==========================
                Text(item.clue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // ==========================
                // MAIN IMAGE SECTION
                // Demonstrates:
                // • Animation
                // • Zoom gesture
                // • Image styling
                // ==========================
                Image("combo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(20)
                    .shadow(radius: 8)

                    // Zoom effect controlled by pinch gesture
                    .scaleEffect(scale)

                    // Small pulse animation effect
                    .scaleEffect(animate ? 1.02 : 1)

                    // Detect pinch gesture to zoom image
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                    )

                    // Start animation when view appears
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                        ) {
                            animate = true
                        }
                    }

                // ==========================
                // TOGGLE: MARK ITEM FOUND
                // ==========================
                Toggle("Mark As Found", isOn: $item.found)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                // ==========================
                // BUTTON: OPEN IMAGE PICKER
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
                // SHOW SELECTED FOUND IMAGE
                // ==========================
                if foundImage != "" {

                    Divider()

                    Text("Found Photo")
                        .font(.headline)

                    // ==========================
                    // FIXED IMAGE CIRCLE DISPLAY
                    // • scaledToFill ensures full coverage
                    // • clipped prevents overflow
                    // • clipShape makes it circular
                    // ==========================
                    Image(foundImage)
                        .resizable()
                        .scaledToFill()     // Fill entire frame properly
                        .frame(width: 200, height: 200)
                        .clipped()          // IMPORTANT FIX: prevents overflow
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 4)
                        )
                        .shadow(radius: 8)

                    // ==========================
                    // SUCCESS MESSAGE
                    // ==========================
                    Text("Great job! Item Found!")
                        .foregroundColor(.green)
                        .bold()
                }

                Spacer()
            }
            .padding()
        }

        // ==========================================
        // SHEET: IMAGE SELECTION GRID
        // ==========================================
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

                        // Loop through available images
                        ForEach(imageChoices, id: \.self) { image in

                            VStack {

                                // Show image option
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)

                                // Image label
                                Text(image)
                                    .font(.caption)
                            }

                            // When user taps an image
                            .onTapGesture {

                                // Save selected image
                                foundImage = image

                                // Mark item as found in main list
                                item.found = true

                                // Close sheet
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

// =============================
// PREVIEW SECTION
// =============================
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            item: .constant(
                ScavengerItem(
                    title: "Coffee Shop",
                    clue: "Find a local coffee shop",
                    imageName: "coffee"
                )
            )
        )
    }
}

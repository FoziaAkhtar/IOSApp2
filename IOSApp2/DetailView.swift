
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

    // =====================================================
    // BINDING: Connected to ContentView data model
    //
    // This allows updates here (e.g., item.found = true)
    // to instantly update the main list screen.
    // =====================================================
    @Binding var item: ScavengerItem

    // Controls whether image selection sheet is visible
    @State private var showChoices = false

    // Stores the image selected by the user
    @State private var foundImage = ""

    // Controls zoom level for pinch gesture
    @State private var scale: CGFloat = 1.0

    // Controls simple pulse animation for UI feedback
    @State private var animate = false

    // List of selectable images for scavenger hunt items
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

                // =====================================================
                // ITEM TITLE
                // Displays the name of the scavenger hunt location/item
                // =====================================================
                
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.top)

                // =====================================================
                // ITEM CLUE
                // Gives the user a hint about what to find
                // =====================================================
                
                Text(item.clue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // =====================================================
                // MAIN IMAGE SECTION
                //
                // Features:
                // • Image display
                // • Zoom gesture (pinch)
                // • Pulse animation effect
                // =====================================================
                
                Image("combo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(20)
                    .shadow(radius: 8)

                    // Combine pinch zoom + pulse animation
                    .scaleEffect(scale * (animate ? 1.02 : 1))

                    // Pinch-to-zoom gesture
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                    )

                    // Start pulse animation when view appears
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                        ) {
                            animate = true
                        }
                    }

                // =====================================================
                // MARK AS FOUND TOGGLE
                //
                // Allows user to mark the item as completed
                // Updates shared data via Binding
                // =====================================================
                
                Toggle("Mark As Found", isOn: $item.found)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                // =====================================================
                // SELECT FOUND IMAGE BUTTON
                //
                // Opens a sheet where user chooses a photo
                // =====================================================
                
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

                // =====================================================
                // FOUND IMAGE DISPLAY (A+ POLISHED SECTION)
                //
                // Only appears when user selects an image
                // Includes:
                // • Circular crop
                // • Glow effect
                // • Animation
                // =====================================================
                
                if foundImage != "" {

                    Divider()

                    Text("Found Photo")
                        .font(.headline)

                    ZStack {

                        // Background glow effect (visual enhancement)
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 220, height: 220)
                            .blur(radius: 3)

                        // Main circular image display
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
                            .shadow(radius: 10)

                            // Subtle pulse animation for emphasis
                            .scaleEffect(animate ? 1.05 : 1)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                                value: animate
                            )
                    }

                    // Success message shown after selection
                    Text("Great job! Item Found! 🎉")
                        .foregroundColor(.green)
                        .bold()
                }

                Spacer()
            }
            .padding()
        }

        // =====================================================
        // IMAGE SELECTION SHEET
        //
        // Displays grid of available images for selection
        // =====================================================
        
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

                            // User selects an image
                            .onTapGesture {

                                // Save selected image
                                foundImage = image

                                // Mark item as found in main list
                                item.found = true

                                // Close selection sheet
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
// PREVIEW
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

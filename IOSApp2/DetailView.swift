
// =============================
// DetailView.swift
// IOSApp2
// =============================
//
// PURPOSE:
//
// This screen shows details for a scavenger hunt item.
//
// USER CAN:
// • View clue
// • Select a photo
// • Mark item as found
// • See feedback (correct / wrong)
//
// =============================

import SwiftUI

struct DetailView: View {

    // =====================================================
    // BINDING: Connects this item to ContentView
    //
    // Any change here updates main list automatically
    // =====================================================
    
    @Binding var item: ScavengerItem

    // Controls image selection sheet
    @State private var showChoices = false

    // Stores selected image name
    @State private var foundImage = ""

    // Controls zoom gesture
    @State private var scale: CGFloat = 1.0

    // Controls simple animation effect
    @State private var animate = false

    // NEW: Message shown to user (correct / wrong)
    @State private var message = ""

    // Available images in the game
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
                // ITEM TITLE
                // ==========================
                
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.top)

                // ==========================
                // ITEM CLUE
                // ==========================
                
                Text(item.clue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // ==========================
                // MAIN IMAGE
                // Includes zoom + animation
                // ==========================
                
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
                // MARK AS FOUND TOGGLE
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
                            Circle().stroke(Color.blue, lineWidth: 4)
                        )
                        .shadow(radius: 8)
                }

                // ==========================
                // FEEDBACK MESSAGE
                // ==========================
                
                if message != "" {

                    Text(message)
                        .font(.headline)
                        .padding()
                        .foregroundColor(
                            item.found ? .green : .red
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
                            // FIXED LOGIC (NO HARDCODE)
                            //
                            // Correct vs Wrong is based ONLY
                            // on whether item is marked found
                            // ==========================
                            
                            .onTapGesture {

                                // Save selected image
                                foundImage = image

                                // If user marked item as found → correct
                                if item.found {

                                    message = "✅ Correct item found!"

                                } else {

                                    message = "❌ Wrong item selected!"
                                }

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

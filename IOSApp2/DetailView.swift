
// =============================
// DetailView.swift
// IOSApp2
// Assignment 4 (A+ Version)
// =============================
//
// Purpose:
//
// This screen shows detailed information
// about a scavenger hunt item.
//
// User can:
// • Read clue
// • View main image
// • Mark item as found
// • Select a found image
// • Zoom image (pinch gesture)
// • See animations and feedback
//
// =============================

import SwiftUI

struct DetailView: View {

    // ==========================================
    // Binding from ContentView
    //
    // This allows changes here (found = true)
    // to update the main list automatically
    // ==========================================
    @Binding var item: ScavengerItem

    // ==========================================
    // Controls sheet for selecting image
    // ==========================================
    @State private var showChoices = false

    // ==========================================
    // Stores selected "found" image
    // ==========================================
    @State private var foundImage = ""

    // ==========================================
    // Zoom scale for pinch gesture
    // ==========================================
    @State private var scale: CGFloat = 1.0

    // ==========================================
    // Controls pulse animation
    // ==========================================
    @State private var animate = false

    // ==========================================
    // Available images for selection
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
                // CLUE TEXT
                // ==========================
                
                Text(item.clue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // ==========================
                // MAIN IMAGE WITH ANIMATION + ZOOM
                // ==========================
                
                Image("combo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(20)
                    .shadow(radius: 8)

                    // IMPORTANT FIX:
                    // Combine zoom + pulse correctly
                    .scaleEffect(scale * (animate ? 1.02 : 1))

                    // PINCH ZOOM GESTURE
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                    )

                    // PULSE ANIMATION
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
                // FOUND IMAGE DISPLAY (A+ FIXED)
                // ==========================
                if foundImage != "" {

                    Divider()

                    Text("Found Photo")
                        .font(.headline)

                    ZStack {

                        // ======================
                        // GLOW BACKGROUND (A+ EFFECT)
                        // ======================
                        
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 220, height: 220)
                            .blur(radius: 3)

                        // ======================
                        // MAIN FOUND IMAGE
                        // ======================
                        
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
                            .scaleEffect(animate ? 1.05 : 1)
                            .animation(.easeInOut(duration: 1).repeatForever(),
                                       value: animate)
                    }

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

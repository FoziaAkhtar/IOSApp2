
// =============================
// DetailView.swift
// IOSApp2
// Assignment 4
// =============================
//
// Purpose:
//
// Displays details for one
// scavenger hunt item.
//
// Features:
//
// • Shows title and clue
// • Displays scavenger image
// • Allows item to be marked found
// • Lets user select a found image
// • Shows selected image
// • Zoom gesture
// • Animation
// • Grid layout
// • Styled UI
//
// Concepts Demonstrated:
//
// • @Binding
// • @State
// • ScrollView
// • LazyVGrid
// • Sheet
// • Gesture
// • Animation
// • Image Styling
//
// =============================

import SwiftUI

struct DetailView: View {

    // ==========================================
    // Receives selected scavenger hunt item
    // from ContentView
    // ==========================================

    @Binding var item: ScavengerItem

    // ==========================================
    // Controls image selection popup
    // ==========================================

    @State private var showChoices = false

    // ==========================================
    // Stores image selected by user
    // ==========================================

    @State private var foundImage = ""

    // ==========================================
    // Used for zoom gesture
    // ==========================================

    @State private var scale: CGFloat = 1.0

    // ==========================================
    // Used for simple animation
    // ==========================================

    @State private var animate = false

    // ==========================================
    // Available scavenger hunt images
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

                // ==================================
                // Item Title
                // ==================================

                Text(item.title)

                    .font(.largeTitle)

                    .bold()

                    .foregroundColor(.blue)

                    .padding(.top)

                // ==================================
                // Item Clue
                // ==================================

                Text(item.clue)

                    .font(.headline)

                    .multilineTextAlignment(.center)

                    .padding(.horizontal)

                // ==================================
                // Main Scavenger Hunt Image
                //
                // Demonstrates:
                // • Image Styling
                // • Animation
                // • Gesture
                // ==================================

                Image("combo")

                    .resizable()

                    .scaledToFit()

                    .frame(height: 220)

                    .cornerRadius(20)

                    .shadow(radius: 8)

                    .scaleEffect(scale)

                    .scaleEffect(animate ? 1.02 : 1)

                    .gesture(

                        MagnificationGesture()

                            .onChanged {

                                scale = $0

                            }

                    )

                    .onAppear {

                        withAnimation(

                            .easeInOut(duration: 1)

                            .repeatForever(

                                autoreverses: true

                            )

                        ) {

                            animate = true

                        }

                    }

                // ==================================
                // Found Toggle
                // ==================================

                Toggle(

                    "Mark As Found",

                    isOn: $item.found

                )

                .padding()

                .background(

                    Color.blue.opacity(0.1)

                )

                .cornerRadius(12)

                .padding(.horizontal)

                // ==================================
                // Upload Button
                // ==================================

                Button {

                    showChoices = true

                } label: {

                    Label(

                        "Select Found Photo",

                        systemImage: "photo"

                    )

                    .font(.headline)

                    .padding()

                    .frame(maxWidth: .infinity)

                }

                .buttonStyle(.borderedProminent)

                .padding(.horizontal)

                // ==================================
                // Show selected image
                // ==================================

                if foundImage != "" {

                    Divider()

                    Text("Found Photo")

                        .font(.headline)

                    Image(foundImage)

                        .resizable()

                        .scaledToFill()

                        .frame(

                            width: 200,

                            height: 200

                        )

                        .clipShape(Circle())

                        .overlay(

                            Circle()

                                .stroke(

                                    Color.blue,

                                    lineWidth: 4

                                )

                        )

                        .shadow(radius: 8)

                    // ==============================
                    // Found confirmation message
                    // ==============================

                    Text("Great job! Item Found!")

                        .foregroundColor(.green)

                        .bold()

                }

                Spacer()

            }

            .padding()

        }

        // ==========================================
        // Image Selection Sheet
        // ==========================================

        .sheet(isPresented: $showChoices) {

            NavigationView {

                ScrollView {

                    // ==============================
                    // Grid Layout
                    // ==============================

                    LazyVGrid(

                        columns: [

                            GridItem(.flexible()),

                            GridItem(.flexible())

                        ],

                        spacing: 20

                    ) {

                        ForEach(

                            imageChoices,

                            id: \.self

                        ) { image in

                            VStack {

                                Image(image)

                                    .resizable()

                                    .scaledToFit()

                                    .frame(

                                        width: 120,

                                        height: 120

                                    )

                                    .cornerRadius(12)

                                    .shadow(radius: 3)

                                Text(image)

                                    .font(.caption)

                            }

                            // ==========================
                            // User selects image
                            // ==========================

                            .onTapGesture {

                                foundImage = image

                                item.found = true

                                showChoices = false

                            }

                        }

                    }

                    .padding()

                }

                .navigationTitle(

                    "Choose Found Item"

                )

            }

        }

    }

}

// ==========================================
// Preview
// ==========================================

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

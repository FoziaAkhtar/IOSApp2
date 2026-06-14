
// =============================================
// IOSApp2 - Scavenger Hunt App
// DetailView.swift
// =============================================
//
// PURPOSE:
//
// This screen shows detailed information for
// a selected scavenger hunt item.
//
// USER CAN:
// • Read clue
// • Select an image
// • Mark item as found
// • Get feedback (correct / wrong)
// • View selected image in a styled circle
//
// =============================================

import SwiftUI

struct DetailView: View {

    // =========================================
    // BINDING: CONNECTS TO MAIN LIST (ContentView)
    //
    // Any change here updates the main screen
    // automatically
    // =========================================
    
    @Binding var item: ScavengerItem

    // =========================================
    // CONTROLS IMAGE SELECTION SHEET
    // =========================================
    
    @State private var showChoices = false

    // =========================================
    // STORES IMAGE FOR DISPLAY PURPOSE
    // (What user selected visually)
    // =========================================
    
    @State private var foundImage = ""

    // =========================================
    // STORES IMAGE FOR LOGIC CHECK
    // (Used to compare with correct answer)
    // =========================================
    
    @State private var selectedImage = ""

    // =========================================
    // CONTROLS PINCH ZOOM SCALE
    // =========================================
    
    @State private var scale: CGFloat = 1.0

    // =========================================
    // CONTROLS PULSE ANIMATION
    // =========================================
    
    @State private var animate = false

    // =========================================
    // FEEDBACK MESSAGE (CORRECT / WRONG)
    // =========================================
    
    @State private var message = ""

    // =========================================
    // LIST OF AVAILABLE SCAVENGER IMAGES
    // =========================================
    
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

                // =====================================
                // ITEM TITLE
                // =====================================
                
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.top)

                // =====================================
                // ITEM CLUE
                // =====================================
                
                Text(item.clue)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // =====================================
                // MAIN IMAGE (ANIMATED + ZOOM)
                // =====================================
                
                Image("combo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(20)
                    .shadow(radius: 8)

                    // Combine zoom + pulse animation
                    .scaleEffect(scale * (animate ? 1.02 : 1))

                    // PINCH ZOOM GESTURE
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                    )

                    // START PULSE ANIMATION
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                        ) {
                            animate = true
                        }
                    }

                // =====================================
                // MARK AS FOUND TOGGLE
                // =====================================
                
                Toggle("Mark As Found", isOn: $item.found)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                // =====================================
                // BUTTON: OPEN IMAGE PICKER
                // =====================================
                
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

                // =====================================
                // DISPLAY SELECTED IMAGE (CIRCLE FIXED)
                // =====================================
                
                if foundImage != "" {

                    Divider()

                    Text("Found Photo")
                        .font(.headline)

                    Image(foundImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill) // fills circle properly
                        .frame(width: 200, height: 200)
                        .clipShape(Circle()) // makes it circular
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 4)
                        )
                        .clipped() // removes overflow
                        .shadow(radius: 8)
                }

                // =====================================
                // FEEDBACK MESSAGE (CORRECT / WRONG)
                // =====================================
                
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

        // =====================================
        // IMAGE SELECTION SHEET
        // =====================================
        
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

                                // IMAGE OPTION
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)

                                // LABEL
                                Text(image)
                                    .font(.caption)
                            }

                            // =====================================
                            // CORE LOGIC (FIXED FOR ALL ITEMS)
                            //
                            // Compares selected image with
                            // THIS item’s correct image name
                            //
                            // NO HARD-CODING → works for all items
                            // =====================================
                            
                            .onTapGesture {

                                // Store selected image
                                selectedImage = image
                                foundImage = image

                                // CHECK IF CORRECT FOR THIS ITEM
                                if selectedImage == item.imageName {

                                    // CORRECT SELECTION
                                    item.found = true
                                    message = "✅ Correct item found!"

                                } else {

                                    // WRONG SELECTION
                                    item.found = false
                                    message = "❌ Wrong item selected!"
                                }

                                // CLOSE SHEET
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


// ===========================
// DetailView.swift
// IOSApp2
// ===========================
// Shows scavenger hunt details
// Allows selecting found picture
// ===========================

import SwiftUI

struct DetailView: View {

    // Receives selected scavenger item
    @Binding var item: ScavengerItem

    // Controls popup sheet visibility
    @State private var showChoices = false

    // Stores image selected by user
    @State private var foundImage:String = ""

    // List of all possible images
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

        // ScrollView allows screen scrolling
        ScrollView {

            VStack(spacing:20) {

                // ================================================
                // Item title
                // ================================================

                Text(item.title)

                    .font(.largeTitle)

                    .bold()


                // ================================================
                // Item clue
                // ================================================

                Text(item.clue)

                    .font(.headline)


                // ===============================================
                // Combo image shown for every page
                // Add your collage image as:
                // combo.imageset
                // ===============================================

                Image("combo")

                    .resizable()

                    .scaledToFit()

                    .frame(height:220)


                // ================================================
                // Mark item found toggle
                // ================================================

                Toggle(

                    "Mark As Found",

                    isOn:$item.found

                )

                .padding()


                // ===============================================
                // Opens image selection popup
                // ================================================

                Button("Upload Photo") {

                    showChoices = true

                }

                .buttonStyle(.borderedProminent)


                // ==================================================
                // Shows selected individual picture
                // ==================================================
                
                if foundImage != "" {

                    Text("Found Photo")

                        .font(.headline)

                    Image(foundImage)

                        .resizable()

                        .scaledToFit()

                        .frame(height:180)

                        .cornerRadius(12)

                }


                Spacer()

            }

            .padding()

        }


        // ================================================
        // Popup sheet showing all images
        // ================================================

        .sheet(isPresented:$showChoices) {

            NavigationView {

                ScrollView {

                    LazyVGrid(

                        columns:[

                            GridItem(.flexible()),

                            GridItem(.flexible())

                        ],

                        spacing:20

                    ) {

                        // ===============================================
                        // Creates image grid
                        // ===============================================

                        ForEach(imageChoices,id:\.self) {

                            image in

                            VStack {

                                Image(image)

                                    .resizable()

                                    .scaledToFit()

                                    .frame(

                                        width:120,

                                        height:120

                                    )

                                Text(image)

                            }

                            // ==============================================
                            // User taps image
                            // ==============================================

                            .onTapGesture {

                                foundImage = image

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

// =========================
//  DetailView.swift
// =========================

import SwiftUI

struct DetailView: View {

    @Binding var item: ScavengerItem

    // controls image picker popup
    @State private var showChoices = false

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

        VStack(spacing:20) {

            Text(item.title)

                .font(.largeTitle)

            Text(item.clue)

            // Current selected image

            Image(item.imageName)

                .resizable()

                .scaledToFit()

                .frame(height:200)

            Toggle(

                "Mark As Found",

                isOn:$item.found

            )

            Button("Upload Photo") {

                showChoices = true

            }

            .buttonStyle(.borderedProminent)

            Spacer()

        }

        .padding()

        .sheet(isPresented:$showChoices) {

            ScrollView {

                LazyVGrid(

                    columns:[
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]

                ) {

                    ForEach(imageChoices,id:\.self) { image in

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

                        .onTapGesture {

                            item.imageName = image

                            showChoices = false

                        }

                    }

                }

                .padding()

            }

        }

    }

}

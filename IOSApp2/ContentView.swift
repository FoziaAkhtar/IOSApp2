
// ===========================
// ContentView.swift
// IOSApp2
// Assignment 4
// ===========================
//
// Purpose:
//
// Main screen of the Scavenger Hunt App
//
// Features:
//
// • App Title
// • Progress Tracking
// • Reward System
// • Styled User Interface
// • GeometryReader Layout
// • Navigation to Detail Pages
// • Navigation to Completion Screen
//
// Concepts Demonstrated:
//
// • NavigationView
// • NavigationLink
// • GeometryReader
// • ObservableObject
// • @StateObject
// • List
// • VStack / HStack
// • LinearGradient
//
// ===========================

import SwiftUI

struct ContentView: View {

    // ======================================
    // Shared ViewModel
    //
    // Stores all scavenger hunt data
    // and updates UI automatically
    // ======================================

    @StateObject private var vm = ScavengerViewModel()

    var body: some View {

        NavigationView {

            GeometryReader { geo in

                VStack(spacing: 15) {

                    // ==================================
                    // App Title
                    // ==================================

                    Text("Scavenger Hunt")

                        .font(.largeTitle)

                        .bold()

                        .foregroundColor(.white)

                        .padding(.top)


                    // ==================================
                    // Progress Counter
                    // Example:
                    // Found: 3 / 10
                    // ==================================

                    Text("Found: \(vm.foundCount)/10")

                        .font(.headline)

                        .foregroundColor(.white)


                    // ==================================
                    // Reward Message
                    // ==================================

                    Text(vm.reward)

                        .font(.title3)

                        .foregroundColor(.yellow)

                        .padding(.bottom)


                    // ==================================
                    // Completion Screen Link
                    //
                    // Only appears after all
                    // 10 items are found
                    // ==================================

                    if vm.foundCount == 10 {

                        NavigationLink {

                            CompletionView(

                                reward: vm.reward

                            )

                        } label: {

                            Text("View Reward")

                                .font(.headline)

                                .foregroundColor(.white)

                                .padding()

                                .background(.green)

                                .cornerRadius(12)

                        }

                    }


                    // ==================================
                    // Scavenger Hunt Item List
                    // ==================================

                    List {

                        ForEach(

                            vm.items.indices,

                            id: \.self

                        ) { index in

                            NavigationLink(

                                destination:

                                    DetailView(

                                        item:

                                            $vm.items[index]

                                    )

                            ) {

                                HStack(spacing: 15) {

                                    // ======================
                                    // Found Status Icon
                                    // ======================

                                    Image(

                                        systemName:

                                        vm.items[index].found

                                        ?

                                        "checkmark.circle.fill"

                                        :

                                        "circle"

                                    )

                                    .foregroundColor(

                                        vm.items[index].found

                                        ?

                                        .green

                                        :

                                        .gray

                                    )

                                    .font(.title2)


                                    // ======================
                                    // Item Information
                                    // ======================

                                    VStack(

                                        alignment: .leading,

                                        spacing: 4

                                    ) {

                                        Text(

                                            vm.items[index].title

                                        )

                                        .font(.headline)


                                        Text(

                                            vm.items[index].clue

                                        )

                                        .font(.caption)

                                        .foregroundColor(.secondary)

                                    }

                                }

                                .padding(.vertical, 5)

                            }

                        }

                    }

                    .scrollContentBackground(.hidden)

                }

                .frame(

                    width: geo.size.width,

                    height: geo.size.height

                )

                .background(

                    LinearGradient(

                        colors: [

                            .blue,

                            .purple

                        ],

                        startPoint: .topLeading,

                        endPoint: .bottomTrailing

                    )

                )

            }

            .navigationBarHidden(true)

        }

    }

}


// ==========================================
// Preview Provider
// ==========================================

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }

}

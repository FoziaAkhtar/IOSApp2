
// ===========================
// ContentView.swift
// IOSApp2
// Assignment 4
// ===========================
//
// Purpose:
//
// This is the main screen of the Scavenger Hunt app.
// It displays:
// • App title
// • Progress tracking
// • List of scavenger hunt items
// • Navigation to detail screens
// • Navigation to completion screen
//
// ===========================

import SwiftUI

// Main home screen of the app
struct ContentView: View {

    // ======================================
    // ViewModel (ObservableObject)
    //
    // This stores all scavenger hunt data:
    // • Items list
    // • Found count
    // • Reward message
    //
    // @StateObject ensures data persists
    // ======================================
    @StateObject private var vm = ScavengerViewModel()

    var body: some View {

        NavigationView {

            // GeometryReader allows responsive layout
            GeometryReader { geo in

                VStack(spacing: 15) {

                    // ==========================
                    // APP TITLE
                    // ==========================
                    Text("Scavenger Hunt")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top)

                    // ==========================
                    // PROGRESS COUNTER
                    //
                    // Shows how many items
                    // user has found
                    // ==========================
                    Text("Found: \(vm.foundCount)/10")
                        .font(.headline)
                        .foregroundColor(.white)

                    // ==========================
                    // REWARD MESSAGE
                    //
                    // Changes based on progress
                    // Example: "Great job!"
                    // ==========================
                    Text(vm.reward)
                        .font(.title3)
                        .foregroundColor(.yellow)
                        .padding(.bottom)

                    // ==========================
                    // COMPLETION BUTTON
                    //
                    // Only appears when all items
                    // are marked as found
                    // ==========================
                    if vm.foundCount == 10 {

                        NavigationLink {

                            // Navigate to reward screen
                            CompletionView(reward: vm.reward)

                        } label: {

                            Text("View Reward")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }

                    // ==========================
                    // SCAVENGER LIST
                    // ==========================
                    List {

                        ForEach(vm.items.indices, id: \.self) { index in

                            NavigationLink(

                                // Go to detail screen
                                destination: DetailView(item: $vm.items[index])

                            ) {

                                HStack(spacing: 15) {

                                    // ======================
                                    // STATUS ICON
                                    //
                                    // Shows if item is found
                                    // ======================
                                    Image(systemName: vm.items[index].found
                                          ? "checkmark.circle.fill"
                                          : "circle")
                                        .foregroundColor(vm.items[index].found
                                                          ? .green
                                                          : .gray)
                                        .font(.title2)

                                    // ======================
                                    // ITEM INFO
                                    // ======================
                                    VStack(alignment: .leading, spacing: 4) {

                                        Text(vm.items[index].title)
                                            .font(.headline)

                                        Text(vm.items[index].clue)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()
                                }
                                .padding(.vertical, 5)

                                // ======================
                                // IMPORTANT IMPROVEMENT
                                //
                                // This makes found items
                                // feel more visually complete
                                // ======================
                                .background(
                                    vm.items[index].found
                                    ? Color.green.opacity(0.1)
                                    : Color.clear
                                )
                                .cornerRadius(8)
                            }
                        }
                    }

                    // Remove default list background
                    .scrollContentBackground(.hidden)
                }

                // Force full screen layout
                .frame(width: geo.size.width,
                       height: geo.size.height)

                // Background gradient styling
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }

            // Hide default navigation bar
            .navigationBarHidden(true)
        }
    }
}

// ===========================
// Preview
// ===========================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

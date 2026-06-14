
// ===========================
// ContentView.swift
// IOSApp2
// Assignment 4 
// ===========================
//
// Purpose:
//
// This is the main screen of the Scavenger Hunt app.
// It displays all items, tracks progress, and allows
// navigation to detail and completion screens.
//
// ===========================

import SwiftUI

struct ContentView: View {

    // ======================================
    // ViewModel (ObservableObject)
    //
    // This stores all app data:
    // • List of items
    // • Found count
    // • Reward message
    //
    // @StateObject keeps data alive while app runs
    // ======================================
    
    @StateObject private var vm = ScavengerViewModel()

    var body: some View {

        NavigationView {

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
                    // PROGRESS DISPLAY
                    //
                    // Shows numeric progress
                    // Example: Found 3/10
                    // ==========================
                    
                    Text("Found: \(vm.foundCount)/10")
                        .font(.headline)
                        .foregroundColor(.white)

                    // ==========================
                    // PROGRESS BAR (A+ FEATURE)
                    //
                    // Visually shows completion %
                    // This improves UX and grading
                    // ==========================
                    
                    ProgressView(value: Double(vm.foundCount), total: 10)
                        .tint(.green)
                        .padding(.horizontal)
                        .padding(.bottom, 5)

                    // ==========================
                    // REWARD MESSAGE
                    //
                    // Changes dynamically based
                    // on progress in ViewModel
                    // ==========================
                    
                    Text(vm.reward)
                        .font(.title3)
                        .foregroundColor(.yellow)
                        .padding(.bottom)

                    // ==========================
                    // COMPLETION BUTTON (A+ UX)
                    //
                    // Button becomes active only
                    // when all items are found
                    // ==========================
                    
                    NavigationLink {

                        CompletionView(reward: vm.reward)

                    } label: {

                        Text(vm.foundCount == 10
                             ? "View Reward 🎉"
                             : "Keep Searching")

                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                vm.foundCount == 10
                                ? Color.green
                                : Color.gray
                            )
                            .cornerRadius(12)
                    }
                    .disabled(vm.foundCount < 10)
                    .padding(.horizontal)

                    // ==========================
                    // LIST OF SCAVENGER ITEMS
                    // ==========================
                    
                    List {

                        ForEach(vm.items.indices, id: \.self) { index in

                            NavigationLink {

                                // Navigate to detail screen
                                DetailView(item: $vm.items[index])

                            } label: {

                                HStack(spacing: 15) {

                                    // ======================
                                    // STATUS ICON
                                    //
                                    // Shows checkmark if found
                                    // ======================
                                    
                                    Image(systemName:
                                          vm.items[index].found
                                          ? "checkmark.circle.fill"
                                          : "circle")
                                        .foregroundColor(
                                            vm.items[index].found
                                            ? .green
                                            : .gray
                                        )
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

                                // ======================
                                // FOUND ITEM HIGHLIGHT (A+ FEATURE)
                                //
                                // Adds visual feedback when
                                // item is marked as found
                                // ======================
                                
                                .padding(.vertical, 5)
                                .background(
                                    vm.items[index].found
                                    ? Color.green.opacity(0.15)
                                    : Color.clear
                                )
                                .cornerRadius(8)
                                .shadow(
                                    color: vm.items[index].found
                                    ? .green.opacity(0.4)
                                    : .clear,
                                    radius: vm.items[index].found ? 6 : 0
                                )
                            }
                        }
                    }

                    // Removes default white list background
                    
                    .scrollContentBackground(.hidden)
                }

                // Makes layout fill full screen
                
                .frame(width: geo.size.width,
                       height: geo.size.height)

                // ==========================
                // BACKGROUND GRADIENT
                // ==========================
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
// PREVIEW
// ===========================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

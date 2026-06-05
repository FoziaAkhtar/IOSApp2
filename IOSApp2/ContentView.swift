
// ===========================
// ContentView.swift
// IOSApp2
// ===========================
// Main screen of the scavenger hunt app
// Displays:
//
// - App title
// - Progress count
// - Reward message
// - List of scavenger hunt items
// - Navigation to detail pages
// ===========================

import SwiftUI

struct ContentView: View {

    // ======================================
    // Creates ONE shared ViewModel object
    // StateObject keeps data alive while app runs
    // ======================================

    @StateObject private var vm = ScavengerViewModel()

    var body: some View {

        // ============================================
        // NavigationView allows moving between screens
        // ============================================

        NavigationView {

            // ================================================
            // Vertical stack places views top → bottom
            // ================================================

            VStack {

                // =============================================
                // App title
                // ==============================================

                Text("Scavenger Hunt")

                    .font(.largeTitle)

                    .bold()


                // ===============================================
                // Progress counter
                // Example:
                // Found: 4/10
                // ===============================================

                Text(

                    "Found: \(vm.foundCount)/10"

                )


                // ===============================================
                // Reward message from ViewModel
                //
                // Examples:
                //
                // Keep Searching!
                // 10% Discount
                // 20% Discount
                //  ================================================

                Text(vm.reward)

                    .foregroundColor(.blue)

                    .padding()


                // ==================================================
                // List automatically scrolls
                //
                // Creates all scavenger hunt rows
                // =================================================

                List {

                    // ===============================================
                    // Loop through all items
                    //
                    // indices gives:
                    // 0,1,2,3...
                    // ================================================

                    ForEach(

                        vm.items.indices,

                        id:\.self

                    ) { index in


                        // ==============================================
                        // Clicking row opens DetailView
                        // ==============================================

                        NavigationLink(

                            destination:

                                DetailView(

                                    item:

                                    $vm.items[index]

                                )

                        ) {


                            // ================================================
                            // Horizontal layout:
                            //
                            // [icon] text
                            // ================================================

                            HStack {


                                // =============================================
                                // Show circle if not found
                                //
                                // Show checkmark if found
                                // =============================================

                                Image(

                                    systemName:

                                    vm.items[index].found

                                    ?

                                    "checkmark.circle.fill"

                                    :

                                    "circle"

                                )


                                // ================================================
                                // Stack title + clue vertically
                                // ================================================

                                VStack(

                                    alignment:.leading

                                ) {


                                    // ============================================
                                    // Item title
                                    //
                                    // Example:
                                    // Coffee Shop
                                    // =============================================

                                    Text(

                                        vm.items[index].title

                                    )


                                    // ==============================================
                                    // Smaller clue text
                                    //
                                    // Example:
                                    // Find local coffee shop
                                    // ===============================================

                                    Text(

                                        vm.items[index].clue

                                    )

                                    .font(.caption)

                                }

                            }

                        }

                    }

                }

            }

        }

    }

}


// ==========================================
// Preview for Xcode canvas
// ==========================================

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }

}

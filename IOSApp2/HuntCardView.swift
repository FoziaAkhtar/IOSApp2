
// ==========================
// HuntCardView.swift
// IOSApp2
// ==========================
// Reusable card component
//
// Purpose:
//
// Displays scavenger hunt items
// inside a styled card
//
// Example:
//
// ----------------------
// |   Coffee Shop      |
// ----------------------
//
// Reusable means:
//
// HuntCardView(title:"Coffee")
// HuntCardView(title:"Library")
//
// can both use same design
// ==========================

import SwiftUI

struct HuntCardView: View {

    // ================================================
    // Receives title text from another screen
    //
    // Example:
    //
    // HuntCardView(
    //     title:"Coffee Shop"
    // )
    // ================================================

    var title:String


    // ===============================================
    // UI displayed on screen
    // ===============================================

    var body: some View {


        // ================================================
        // VStack stacks items vertically
        //
        // Current card only has text
        // but more items can be added later
        // ================================================

        VStack {


            // =======================================
            // Display card title
            // =======================================

            Text(title)

                // ==================================
                // Larger font size
                // ==================================
            
                .font(.title2)


                // =======================================
                // Adds spacing around text
                // ========================================

                .padding()

        }


        // ================================================
        // Makes card stretch horizontally
        // ================================================

        .frame(

            maxWidth:.infinity

        )


        // ================================================
        // Adds light blue background
        // ================================================

        .background(

            .blue.opacity(0.2)

        )


        // ================================================
        // Rounds card corners
        // ================================================

        .cornerRadius(15)

    }

}

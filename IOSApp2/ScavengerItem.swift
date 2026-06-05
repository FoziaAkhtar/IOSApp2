
// ===========================
// ScavengerItem.swift
// IOSApp2
// ===========================
//
// Purpose:
//
// Creates ONE scavenger hunt item
//
// Each item stores:
//
// - Title
// - Clue
// - Found status
// - Image name
//
// Example:
//
// Coffee Shop
// Find a local coffee shop
//
// ===========================

import Foundation


// ===========================
// ScavengerItem model
//
// Identifiable allows SwiftUI
// lists to uniquely identify
// each item automatically
// ===========================

struct ScavengerItem: Identifiable {


    // ===========================
    // Unique identifier
    //
    // Every scavenger item gets
    // its own automatically
    // generated ID
    // ===========================

    let id = UUID()


    // ===========================
    // Stores item name
    //
    // Example:
    //
    // Coffee Shop
    // Library
    // Restaurant
    // ===========================

    var title:String


    // ===========================
    // Stores clue shown
    // to the user
    //
    // Example:
    //
    // Find a coffee shop nearby
    // ===========================

    var clue:String


    // ===========================
    // Tracks if item was found
    //
    // false = not found
    // true = found
    //
    // Default value:
    //
    // false
    // ===========================

    var found:Bool = false


    // ===========================
    // Stores image name
    //
    // Example:
    //
    // "coffee"
    // "library"
    // "park"
    //
    // Used for:
    //
    // Image(item.imageName)
    // ===========================

    var imageName:String

}

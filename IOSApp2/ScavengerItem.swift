// ===========================
//  ScavengerItem.swift
//  IOSApp2
// ===========================
// Model for each scavenger hunt item
// ===========================

import Foundation

struct ScavengerItem: Identifiable {

    // Unique ID for each item
    let id = UUID()

    // Name of location/item
    var title:String

    // Clue shown to user
    var clue:String

    // User found item?
    var found:Bool = false

    // Image selected by user
    var imageName:String = ""
}

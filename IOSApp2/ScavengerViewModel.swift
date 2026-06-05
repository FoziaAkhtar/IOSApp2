
// =========================
// ScavengerViewModel.swift
// =========================

import Foundation
import SwiftUI
import Combine

class ScavengerViewModel: ObservableObject {

    // Stores scavenger hunt items
    @Published var items: [ScavengerItem] = ScavengerData.items

    // Count how many items are found
    var foundCount: Int {

        items.filter { $0.found }.count

    }

    // Reward message based on progress
    var reward: String {

        if foundCount == 10 {

            return "Grand Prize Draw + 20% Discount"

        } else if foundCount >= 7 {

            return "20% Discount"

        } else if foundCount >= 5 {

            return "10% Discount"

        } else {

            return "Keep Searching!"

        }

    }

}


// =========================
// ScavengerViewModel.swift
// IOSApp2
// =========================
//
// Purpose:
//
// Controls app data and logic
//
// Responsible for:
//
// - Storing scavenger items
// - Counting found items
// - Calculating rewards
// - Updating UI automatically
//
// =========================

import Foundation
import SwiftUI
import Combine


// =========================
// ViewModel class
//
// ObservableObject allows
// SwiftUI screens to listen
// for data changes automatically
//
// When data changes:
//
// View updates automatically
//
// =========================

class ScavengerViewModel: ObservableObject {
    
    
    // =========================
    // Stores all scavenger items
    //
    // @Published means:
    //
    // If items change,
    // screens automatically update
    //
    // Example:
    //
    // User marks item found
    //
    // UI refreshes automatically
    // =========================
    
    @Published var items:[ScavengerItem] =
    
    ScavengerData.items
    
    
    // =========================
    // Counts found items
    //
    // Example:
    //
    // 3 items found
    //
    // returns:
    //
    // 3
    // =========================
    
    var foundCount:Int {
        
        items.filter {
            
            $0.found
            
        }.count
        
    }
    
    
    // =========================
    // Calculates reward message
    //
    // Reward rules:
    //
    // 0–4 items:
    // Keep Searching!
    //
    // 5–6 items:
    // 10% Discount
    //
    // 7–9 items:
    // 20% Discount
    //
    // 10 items:
    // Grand Prize Draw
    // =========================
    
    var reward:String {
        
        if foundCount == 10 {
            
            return "Grand Prize Draw + 20% Discount"
            
        }
        
        else if foundCount >= 7 {
            
            return "20% Discount"
            
        }
        
        else if foundCount >= 5 {
            
            return "10% Discount"
            
        }
        
        else {
            
            return "Keep Searching!"
            
        }
        
    }
}

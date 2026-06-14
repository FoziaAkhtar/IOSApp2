
// =======================
// IOSApp2App.swift
// =======================

import SwiftUI

@main
struct IOSApp2App: App {
    var body: some Scene {
        WindowGroup {

            // =====================================
            // STARTING SCREEN OF THE APP
            //
            // Changed from ContentView to WelcomeView
            //
            // This makes WelcomeView the first screen
            // user sees when the app opens
            // =====================================
            WelcomeView()

        }
    }
}

🧭 Scavenger Hunt iOS App
📌 Project Overview

The Scavenger Hunt App is an iOS application developed using SwiftUI. It allows users to browse a list of scavenger hunt tasks, view detailed instructions for each item, and upload or select an image as proof of completion. The app demonstrates key iOS development concepts such as navigation, state management, and user interaction.

🎯 Objective

The objective of this project is to create an interactive scavenger hunt experience where users can:

View a list of scavenger hunt items
Select an item to see its details
Capture or choose an image as proof of completion
Track completed tasks within the app
✨ Features
📋 Display list of scavenger hunt items
📱 Navigation between list and detail views
📸 Image selection using photo library or camera
✅ Mark items as completed after selecting an image
🔄 Real-time UI updates using SwiftUI state management
🎨 Clean and user-friendly interface
🛠 Technologies Used
Swift 5
SwiftUI
Xcode (iOS Development Environment)
UIKit Integration (for Image Picker, if used)
🗂 Project Structure

ScavengerHuntApp/
│
├── Models/
│   └── ScavengerItem.swift
│       → Defines the scavenger item data model
│
├── Views/
│   ├── ContentView.swift
│       → Displays list of scavenger items
│   ├── DetailView.swift
│       → Shows item details and image selection
│   └── ImagePicker.swift
│       → Handles camera/photo library access
│
├── Assets/
│   └── Images.xcassets
│
└── ScavengerHuntApp.swift
    → Main app entry point

⚙️ How the App Works
The app launches and displays a list of scavenger hunt items.
The user taps on an item to open its detail view.
The user selects or captures an image as proof of finding the item.
The selected image is stored in the app’s state.
The item is marked as completed once an image is added.
The UI updates automatically using SwiftUI’s reactive system.
📸 User Flow
Open app → View scavenger list
Tap an item → Open detail screen
Choose or take a photo
Save image → Mark item complete
🧠 Key Concepts Demonstrated
SwiftUI Views and Navigation
State management using @State and @Binding
Image handling using UIImagePickerController
Data passing between views
Basic app architecture (Model–View structure)
🚀 How to Run the Project
Open Xcode
Create or open the project
Ensure SwiftUI is selected
Add all provided source files
Run the app using:
iOS Simulator OR
Physical iPhone device
🔮 Future Improvements
Store progress permanently using UserDefaults or CoreData
Add scoring or reward system 🏆
Add location-based scavenger tasks 🌍
Add timer for challenges ⏱
Improve UI with animations
👩‍💻 Developer Notes

This project was built as part of an iOS development assignment to demonstrate understanding of SwiftUI fundamentals, user interaction, and image handling.

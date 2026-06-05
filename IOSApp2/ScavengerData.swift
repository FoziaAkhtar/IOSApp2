
// ===============================
// ScavengerData.swift
// IOSApp2
// ===============================
//
// Purpose:
//
// Stores ALL scavenger hunt items
//
// This acts like a database
// for the scavenger hunt app
//
// ===============================

import Foundation


// ===============================
// Stores scavenger hunt data
// ===============================

class ScavengerData {


    // ===============================
    // Static array containing
    // all scavenger hunt items
    //
    // Static means:
    //
    // ScavengerData.items
    //
    // can be accessed directly
    // ===============================

    static let items:[ScavengerItem] = [


        // ===============================
        // Coffee Shop item
        // ===============================

        ScavengerItem(

            title:"Coffee Shop",

            clue:"Find a local coffee shop",

            imageName:"coffee"

        ),


        // ===============================
        // Restaurant item
        // ===============================

        ScavengerItem(

            title:"Restaurant",

            clue:"Find a restaurant nearby",

            imageName:"restaurant"

        ),


        // ===============================
        // Book Store item
        // ===============================

        ScavengerItem(

            title:"Book Store",

            clue:"Find somewhere books are sold",

            imageName:"book"

        ),


        // ===============================
        // Movie Theatre item
        // ===============================

        ScavengerItem(

            title:"Movie Theatre",

            clue:"Find a place showing movies",

            imageName:"movie"

        ),


        // ===============================
        // Park item
        // ===============================

        ScavengerItem(

            title:"Park",

            clue:"Find a public park",

            imageName:"park"

        ),


        // ===============================
        // Gym item
        // ===============================

        ScavengerItem(

            title:"Gym",

            clue:"Find a fitness center",

            imageName:"gym"

        ),


        // ===============================
        // Bakery item
        // ===============================

        ScavengerItem(

            title:"Bakery",

            clue:"Find fresh baked goods",

            imageName:"bakery"

        ),


        // ===============================
        // Library item
        // ===============================

        ScavengerItem(

            title:"Library",

            clue:"Find local books and study space",

            imageName:"library"

        ),


        // ===============================
        // Pharmacy item
        // ===============================

        ScavengerItem(

            title:"Pharmacy",

            clue:"Find medicine store",

            imageName:"pharmacy"

        ),


        // ===============================
        // Grocery Store item
        // ===============================

        ScavengerItem(

            title:"Grocery Store",

            clue:"Find a food shopping place",

            imageName:"grocery"

        )

    ]

}

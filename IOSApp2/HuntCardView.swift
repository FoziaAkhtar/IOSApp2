// ==========================
//  HuntCardView.swift
// ==========================

import SwiftUI

struct HuntCardView: View {

    var title:String

    var body: some View {

        VStack {

            Text(title)

                .font(.title2)

                .padding()

        }

        .frame(
            maxWidth:.infinity
        )

        .background(.blue.opacity(0.2))

        .cornerRadius(15)

    }

}


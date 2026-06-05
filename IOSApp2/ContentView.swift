// ===========================
// ContentView.swift
// ===========================

import SwiftUI

struct ContentView: View {

    @StateObject private var vm = ScavengerViewModel()

    var body: some View {

        NavigationView {

            VStack {

                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .bold()

                Text("Found: \(vm.foundCount)/10")

                Text(vm.reward)
                    .foregroundColor(.blue)
                    .padding()

                List {

                    ForEach(vm.items.indices, id: \.self) { index in

                        NavigationLink(

                            destination:

                                DetailView(
                                    item: $vm.items[index]
                                )

                        ) {

                            HStack {

                                Image(
                                    systemName:
                                        vm.items[index].found
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )

                                VStack(alignment: .leading) {

                                    Text(vm.items[index].title)

                                    Text(vm.items[index].clue)
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

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }

}

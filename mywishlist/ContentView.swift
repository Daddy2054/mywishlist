//
//  ContentView.swift
//  mywishlist
//
//  Created by Jean on 29/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            }
            .navigationBarTitle("My Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                if wishes.isEmpty != true {
                    ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                    
                }
            }
            .alert("Create a new wish", isPresented: $isAlertShowing) {
                TextField("Enter a wish", text: $title)
                Button {
                    modelContext.insert(Wish(title: title))
                    title = ""
                } label: {
                    Text("Save")
                }
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView("My Wishlist",systemImage: "heart.circle",description: Text("No wishes yet. Add one to get started."))
                }
            }
        }
    }
}

#Preview("List with sample Data") {
    let container = try! ModelContainer(for: Wish.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    container.mainContext.insert(Wish(title: "First wish"))
    container.mainContext.insert(Wish(title: "Second wish"))
    container.mainContext.insert(Wish(title: "third wish"))
    container.mainContext.insert(Wish(title: "Fourth wish"))
    container.mainContext.insert(Wish(title: "fifth wish"))
    return    ContentView()
        .modelContainer(container)
    
    
}
#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory:     true)
}

//
//  mywishlistApp.swift
//  mywishlist
//
//  Created by Jean on 29/11/24.
//

import SwiftUI
import SwiftData

@main
struct mywishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}

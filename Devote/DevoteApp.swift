//
//  DevoteApp.swift
//  Devote
//
//  Created by Jozek Andrzej Hajduk Sanchez on 28/10/24.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

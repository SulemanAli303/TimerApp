//
//  TimerAppApp.swift
//  TimerApp
//
//  Created by Suleman Ali on 24/12/2023.
//

import SwiftUI

@main
struct TimerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

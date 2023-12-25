//
//  TimerAppApp.swift
//  TimerApp
//
//  Created by Suleman Ali on 24/12/2023.
//

import SwiftUI

@main
struct TimerAppApp: App {
    @StateObject var viewModel = TimerViewModel(time: 10)
    @Environment(\.scenePhase) var scene

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                }
        }
    }

    private  func addNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Notification from Timer App"
        content.body = "Timer is finished!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.0, repeats: false)
        let request = UNNotificationRequest(identifier: "TIMER", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        }
    }

   private func removeNotification() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["TIMER"])
    }
}

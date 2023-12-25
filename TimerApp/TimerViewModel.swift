//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Suleman Ali on 25/12/2023.
//

import Foundation
import SwiftUI


class TimerViewModel: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    var time: Double = 60
    @Published var selectedTime: Double = 60
    @Published var isTimerStarted = false
    @Published var progress: CGFloat = 60
    var leftTime: Date!

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        resetView()
        completionHandler()
    }

    func resetView() {
        withAnimation(.easeIn) {
            progress = time
            selectedTime = time
            isTimerStarted = false
            leftTime = nil
        }
    }
}

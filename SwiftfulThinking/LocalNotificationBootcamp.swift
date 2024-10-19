//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 19/10/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    func requestAuthorization() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "Hehe"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
//        var dateComponent = DateComponents()
//        dateComponent.hour = 10
//        dateComponent.minute = 54
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00
        )
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    func resetBadgeCount(){
            UNUserNotificationCenter.current().setBadgeCount(0) { error in
                print("Error \(error.debugDescription)") // returns nil
            }
        }
}

struct LocalNotificationBootcamp: View {
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        VStack(spacing: 40) {
            Button("REQUEST PERMISSION") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("SCHEDULE NOTIFICATION") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("CANCEL NOTIFICATION") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                NotificationManager.instance.resetBadgeCount()
            }
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}

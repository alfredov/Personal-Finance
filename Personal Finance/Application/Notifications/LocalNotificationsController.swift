//
//  LocalNotificationsController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/22/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationsController {
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            self.addNotifications()
        }
    }
    
    func addNotifications() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Hiciste alguna compra el dia de hoy?"
        content.body = "Recuerda agregar los gastos del dia de hoy"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 10.0,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "inteenseconds",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { (error) in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
    }
}

//
//  NotificationManager.swift
//  Your Mom
//
//  Created by Naysha Jain on 8/5/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func schedule(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Your Mom"
        content.body = message(for: reminder)
        content.sound = .default

        var triggerDate: DateComponents

        switch reminder.frequency {
        case .daily:
            // Every day at a specific hour and minute
            triggerDate = Calendar.current.dateComponents([.hour, .minute], from: reminder.time)

        case .weekly:
            // Every week on same weekday + time
            triggerDate = Calendar.current.dateComponents([.weekday, .hour, .minute], from: reminder.time)

        case .monthly:
            // Every month on the same day-of-month + time
            triggerDate = Calendar.current.dateComponents([.day, .hour, .minute], from: reminder.time)
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }


    func message(for reminder: Reminder) -> String {
        let task = reminder.title

        let chaoticLines = [
            "OH MY GOD DID YOU \(task) YET?!",
            "If you don’t \(task) right now, I will lose my mind.",
            "That task? Yeah, \(task)? It's SCREAMING to be done.",
            "It’s been HOW LONG since you \(task)? 😭",
            "THE HOUSE IS FALLING APART. \(task). NOW.",
            "I swear, if I see you skip \(task) again…",
            "We are one missed \(task) away from total collapse.",
            "This is your final warning to \(task) 💀",
            "I'm one reminder away from unplugging the WiFi. \(task).",
            "WHY HAVEN’T YOU \(task)? WHAT ARE YOU DOING?!"
        ]

        let sassyLines = [
            "Not me reminding you again to \(task) 🙄",
            "It’s giving… procrastination. Just \(task).",
            "Oh look, another day of not \(task).",
            "Please \(task) before I lose it.",
            "If I had a dollar for every time I reminded you to \(task)...",
            "You know what would be wild? If you actually \(task).",
            "I shouldn’t have to remind you to \(task), but here we are.",
            "Be a responsible adult and \(task), please.",
            "Guess who forgot to \(task)? (It’s you.)"
        ]

        let sweetLines = [
            "Hey love, don’t forget to \(task) 💗",
            "Just checking in — did you \(task) yet?",
            "Please \(task) when you can. I’m only reminding because I care.",
            "I know you’ve got a lot going on, but try to \(task) today, okay?",
            "Time to \(task), sweetie. You’ll feel better after.",
            "You always feel good when you \(task) — don’t skip it today!",
            "Sending a little nudge to \(task) 💕",
            "Take a moment to \(task). I’ll feel better, and so will you.",
            "Did you remember to \(task)? Just making sure.",
            "You're doing amazing — just don't forget to \(task) too."
        ]

        switch reminder.momTone {
        case .chaotic:
            return chaoticLines.randomElement() ?? task
        case .sassy:
            return sassyLines.randomElement() ?? task
        case .sweet:
            return sweetLines.randomElement() ?? task
        }
    }

}

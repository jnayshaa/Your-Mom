//
//  ReminderListViewController.swift
//  Your Mom
//
//  Created by Naysha Jain on 8/5/25.
//

import Foundation
import UIKit


class ReminderListViewController: UITableViewController {
    var reminders: [Reminder] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadReminders()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReminders()
        tableView.reloadData()
    }

    func loadReminders() {
        if let data = UserDefaults.standard.data(forKey: "reminders"),
           let decoded = try? JSONDecoder().decode([Reminder].self, from: data) {
            reminders = decoded
        } else {
            reminders = []
        }
    }

    func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: "reminders")
        }
    }

    // Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reminders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = reminders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = reminder.title
        config.secondaryText = "\(formattedTime(reminder.time)) • \(reminder.frequency.rawValue.capitalized) • \(reminder.momTone.rawValue.capitalized)"
        cell.contentConfiguration = config
        return cell
    }

    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            reminders.remove(at: indexPath.row)
            saveReminders()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

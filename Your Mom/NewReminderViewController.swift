//
//  NewReminderViewController.swift
//  Your Mom
//
//  Created by Naysha Jain on 8/5/25.
//

import Foundation
import UIKit

class NewReminderViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var frequencySegment: UISegmentedControl!
    @IBOutlet weak var momToneSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegments()
    }

    func setupSegments() {
        frequencySegment.removeAllSegments()
        for (index, freq) in Frequency.allCases.enumerated() {
            frequencySegment.insertSegment(withTitle: freq.rawValue.capitalized, at: index, animated: false)
        }

        momToneSegment.removeAllSegments()
        for (index, tone) in MomTone.allCases.enumerated() {
            momToneSegment.insertSegment(withTitle: tone.rawValue.capitalized, at: index, animated: false)
        }

        frequencySegment.selectedSegmentIndex = 0
        momToneSegment.selectedSegmentIndex = 0
    }

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        
        let frequency = Frequency.allCases[frequencySegment.selectedSegmentIndex]
        let momTone = MomTone.allCases[momToneSegment.selectedSegmentIndex]
        let reminder = Reminder(title: title, time: timePicker.date, frequency: frequency, momTone: momTone)

        save(reminder: reminder)
        NotificationManager.shared.schedule(reminder: reminder)
        dismiss(animated: true)
    }

    func save(reminder: Reminder) {
        var current = [Reminder]()
        if let data = UserDefaults.standard.data(forKey: "reminders"),
           let decoded = try? JSONDecoder().decode([Reminder].self, from: data) {
            current = decoded
        }
        current.append(reminder)
        if let encoded = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(encoded, forKey: "reminders")
        }
    }
}


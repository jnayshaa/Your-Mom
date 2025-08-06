import Foundation

enum Frequency: String, Codable, CaseIterable {
    case daily
    case weekly
    case monthly
}

enum MomTone: String, Codable, CaseIterable {
    case sweet
    case sassy
    case chaotic
}

struct Reminder: Codable {
    let title: String
    let time: Date
    let frequency: Frequency
    let momTone: MomTone
}


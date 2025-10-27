import Foundation

struct Appointment: Identifiable {
    let id = UUID()
    let artist: Artist
    let date: Date
    let durationInMinutes: Int
    let designNotes: String
    let placement: String
    let status: Status

    enum Status: String {
        case confirmed = "Bestätigt"
        case pending = "Ausstehend"
        case completed = "Abgeschlossen"
    }

    static let sample = Appointment(
        artist: Artist.samples.first!,
        date: Calendar.current.date(byAdding: .day, value: 6, to: .now) ?? .now,
        durationInMinutes: 120,
        designNotes: "Feine Linien, goldene Akzente, Fokus auf Architektur & Sonne",
        placement: "Unterarm innen",
        status: .confirmed
    )
}

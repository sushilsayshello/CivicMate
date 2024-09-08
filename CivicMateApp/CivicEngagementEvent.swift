import Foundation  // Needed for UUID

// Renamed to avoid conflicts
struct CivicEngagementEvent: Identifiable {
    var id = UUID()  // Unique identifier for each event
    var title: String  // Title of the event
    var date: Date  // Date of the event
    var location: String  // Location of the event
    var description: String  // Description of the event
}



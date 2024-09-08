import Foundation  // Needed for UUID

// Renamed to avoid conflicts
struct CivicEducationModule: Identifiable {
    var id = UUID()  // Unique identifier for each module
    var title: String  // Title of the education module
    var content: String  // The content for the module
}

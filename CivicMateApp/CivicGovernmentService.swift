import Foundation

// Renamed GovernmentService to CivicGovernmentService
struct CivicGovernmentService: Identifiable {
    var id = UUID()  // Unique ID for each service
    var name: String  // Name of the government service
    var category: String  // Category of the service
    var details: String  // Detailed description of the service
    var iconName: String  // SF Symbol icon name for the service
}

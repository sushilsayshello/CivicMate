import SwiftUI

struct GovernmentServiceAssistantView: View {
    @State private var searchQuery = ""
    @State private var viewedServices: [UUID] = []  // Track services that have been viewed
    @State private var services = [
        GovernmentService(name: "Housing Support", category: "Social Services", details: "Find information about housing assistance programs.", iconName: "house.fill"),
        GovernmentService(name: "Healthcare Assistance", category: "Health", details: "Learn about government healthcare benefits.", iconName: "heart.fill"),
        GovernmentService(name: "Tax Services", category: "Finance", details: "Get help with taxes and filing assistance.", iconName: "dollarsign.circle.fill"),
        GovernmentService(name: "Employment Services", category: "Job Support", details: "Get access to government job support programs.", iconName: "briefcase.fill")
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Government Services")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // Search bar
                TextField("Search Services", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Progress bar to track services that were viewed
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .animation(.easeInOut)

                // List of filtered services displayed in card format
                List(filteredServices) { service in
                    NavigationLink(destination: ServiceDetailView(service: service, viewedServices: $viewedServices)) {
                        ServiceCardView(service: service, isViewed: viewedServices.contains(service.id))
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }

    // Filter services based on search query
    var filteredServices: [GovernmentService] {
        services.filter { service in
            searchQuery.isEmpty ? true : service.name.lowercased().contains(searchQuery.lowercased())
        }
    }

    // Calculate progress based on how many services have been viewed
    var progress: Double {
        return services.isEmpty ? 0 : Double(viewedServices.count) / Double(services.count)
    }
}

struct ServiceCardView: View {
    let service: GovernmentService
    let isViewed: Bool

    var body: some View {
        HStack {
            Image(systemName: service.iconName)
                .foregroundColor(.blue)
                .font(.system(size: 32))
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 10) {
                Text(service.name)
                    .font(.headline)
                    .foregroundColor(isViewed ? .gray : .primary)
                Text(service.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isViewed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 24))
            }
        }
        .padding()
        .background(isViewed ? Color(.systemGray5) : Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ServiceDetailView: View {
    let service: GovernmentService
    @Binding var viewedServices: [UUID]

    @State private var isViewed: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            // Service icon and name
            HStack {
                Image(systemName: service.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .foregroundColor(.blue)
                    .padding(.trailing, 10)

                Text(service.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding()

            // Service details
            Text(service.category)
                .font(.title2)
                .padding(.bottom, 10)
                .padding(.horizontal)

            ScrollView {
                Text(service.details)
                    .font(.body)
                    .padding(.horizontal)
            }

            Spacer()

            // Mark service as viewed
            Button(action: {
                withAnimation {
                    if !viewedServices.contains(service.id) {
                        viewedServices.append(service.id)
                    }
                    isViewed = true
                }
            }) {
                Text(isViewed ? "Viewed" : "Mark as Viewed")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isViewed ? Color.gray : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
            .disabled(isViewed)  // Disable button if already marked as viewed
            .padding(.bottom, 20)
        }
        .navigationBarTitle("Service Details", displayMode: .inline)
    }
}

struct GovernmentService: Identifiable {
    var id = UUID()  // Unique identifier for each service
    var name: String  // Name of the government service
    var category: String  // Category of the service
    var details: String  // Detailed description of the service
    var iconName: String  // Icon representing the service
}

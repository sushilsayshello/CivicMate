import SwiftUI

struct CivicServiceDetailView: View {
    let service: GovernmentService
    @Binding var viewedServices: [UUID]

    @State private var isViewed: Bool = false

    var body: some View {
        VStack {
            // Service Icon and Name
            HStack {
                Image(systemName: service.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(service.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(service.category)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()

            // Service details section
            VStack(alignment: .leading, spacing: 10) {
                Text("Details")
                    .font(.headline)
                    .padding(.top)
                Text(service.details)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.bottom)

                Spacer()
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding()

            Spacer()

            // External link button (for more information, or hypothetical service website)
            Button(action: {
                // Action for opening the service link (if you have URLs, you can use SafariView)
                print("External link opened")
            }) {
                HStack {
                    Image(systemName: "link")
                        .font(.headline)
                    Text("Visit Official Website")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
            .padding(.bottom, 10)

            // Mark as viewed button with visual feedback
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
                    .background(isViewed ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
            .disabled(isViewed)  // Disable the button after marking the service as viewed
            .padding(.bottom, 20)
        }
        .navigationBarTitle("Service Details", displayMode: .inline)
    }
}


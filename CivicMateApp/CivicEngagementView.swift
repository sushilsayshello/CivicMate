import SwiftUI

struct CivicEngagementView: View {
    @State private var civicEvents = [
        CivicEvent(title: "Town Hall Meeting", date: Date().addingTimeInterval(86400), location: "Community Center", description: "Discuss local issues with your community.", isUpcoming: true),
        CivicEvent(title: "Public Consultation", date: Date().addingTimeInterval(-86400), location: "City Hall", description: "Provide feedback on proposed policies.", isUpcoming: false),
        CivicEvent(title: "Environmental Awareness Campaign", date: Date().addingTimeInterval(172800), location: "Central Park", description: "Join a public rally to raise awareness on environmental issues.", isUpcoming: true)
    ]

    @State private var attendedEvents: [UUID] = []  // Track attended events
    @State private var showOnlyUpcoming = true  // Toggle to filter upcoming/past events

    var body: some View {
        NavigationView {
            VStack {
                // Header with a segmented picker for filtering events
                Text("Civic Engagement Portal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Picker("Events", selection: $showOnlyUpcoming) {
                    Text("Upcoming").tag(true)
                    Text("Past").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // Progress bar to track attendance of upcoming events
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .animation(.easeInOut)

                // Filtered list of events
                List(filteredEvents) { event in
                    NavigationLink(destination: EventDetailView(event: event, attendedEvents: $attendedEvents)) {
                        EventCardView(event: event, isAttended: attendedEvents.contains(event.id))
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color(.systemGray6))  // Light gray background
            .navigationBarHidden(true)
        }
    }

    // Filter upcoming or past events based on toggle
    var filteredEvents: [CivicEvent] {
        civicEvents.filter { event in
            showOnlyUpcoming ? event.isUpcoming : !event.isUpcoming
        }
    }

    // Calculate progress based on how many upcoming events were attended
    var progress: Double {
        let upcomingEvents = civicEvents.filter { $0.isUpcoming }
        return upcomingEvents.isEmpty ? 0 : Double(attendedEvents.count) / Double(upcomingEvents.count)
    }
}

struct EventCardView: View {
    let event: CivicEvent
    let isAttended: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.headline)
                    .foregroundColor(isAttended ? .gray : .primary)
                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Date: \(event.date, formatter: eventDateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isAttended {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 24))
            } else {
                Image(systemName: event.isUpcoming ? "clock.fill" : "checkmark.circle")
                    .foregroundColor(event.isUpcoming ? .blue : .gray)
                    .font(.system(size: 24))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct EventDetailView: View {
    let event: CivicEvent
    @Binding var attendedEvents: [UUID]

    @State private var isAttended: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Text("Location: \(event.location)")
                .font(.title2)
                .padding(.vertical)

            Text("Date: \(event.date, formatter: eventDateFormatter)")
                .font(.title3)
                .padding(.bottom)

            ScrollView {
                Text(event.description)
                    .padding(.horizontal)
            }
            .navigationBarTitle("Event Details", displayMode: .inline)

            Spacer()

            Button(action: {
                withAnimation {
                    if !attendedEvents.contains(event.id) {
                        attendedEvents.append(event.id)
                    }
                    isAttended = true
                }
            }) {
                Text(isAttended ? "Attended" : "Mark as Attended")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAttended ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
            .disabled(isAttended)  // Disable button if already attended
            .padding(.bottom, 20)
        }
        .padding()
    }
}

struct CivicEvent: Identifiable {
    var id = UUID()  // Unique identifier for each event
    var title: String  // Title of the event
    var date: Date  // Date of the event
    var location: String  // Location of the event
    var description: String  // Description of the event
    var isUpcoming: Bool  // Whether the event is upcoming or past
}

// Date Formatter for displaying the event date in a readable format
let eventDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

import SwiftUI

struct CivicEducationView: View {
    @State private var completedModules: [UUID] = []  // Track completed modules

    // List of educational modules
    let modules = [
        EducationModule(title: "Democracy Basics", content: "Learn about the foundations of democracy, the pillars of governance, and why it matters."),
        EducationModule(title: "How Voting Works", content: "Understand the voting process in your region, how votes are counted, and the importance of each vote."),
        EducationModule(title: "Role of Government", content: "Explore the different roles of the government, including law-making, enforcing policies, and ensuring welfare.")
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Header with Progress Bar
                Text("Civic Education Hub")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // Progress bar showing module completion progress
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .animation(.easeInOut)

                // List of modules
                List(modules) { module in
                    NavigationLink(destination: ModuleDetailView(module: module, completedModules: $completedModules)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(module.title)
                                    .font(.headline)
                                    .foregroundColor(completedModules.contains(module.id) ? .gray : .black)
                                Text(module.content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            if completedModules.contains(module.id) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "book.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color(.systemGray6))  // Light gray background for modern look
            .navigationBarHidden(true)
        }
    }

    // Calculate progress based on completed modules
    var progress: Double {
        return Double(completedModules.count) / Double(modules.count)
    }
}

struct ModuleDetailView: View {
    let module: EducationModule
    @Binding var completedModules: [UUID]
    
    @State private var isCompleted: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                Text(module.content)
                    .padding()
                Spacer()
            }
            .navigationBarTitle(module.title, displayMode: .inline)

            Button(action: {
                withAnimation {
                    if !completedModules.contains(module.id) {
                        completedModules.append(module.id)
                    }
                    isCompleted = true
                }
            }) {
                Text(isCompleted ? "Completed" : "Mark as Complete")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isCompleted ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                    .animation(.easeInOut)
            }
            .disabled(isCompleted)  // Disable button if already completed
            .padding(.bottom, 20)
        }
    }
}

struct EducationModule: Identifiable {
    var id = UUID()  // Unique identifier for each module
    var title: String  // Title of the education module
    var content: String  // The content for the module
}

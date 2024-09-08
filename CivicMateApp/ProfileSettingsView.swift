import SwiftUI

struct ProfileSettingsView: View {
    @State private var name: String = "John Doe"
    @State private var notificationsEnabled: Bool = true
    @State private var avatar: String = "person.crop.circle.fill"

    var body: some View {
        Form {
            Section(header: Text("User Profile")) {
                HStack {
                    Image(systemName: avatar)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        TextField("Name", text: $name)
                            .font(.headline)
                    }
                }
            }

            Section(header: Text("Notifications")) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
            }

            Button(action: {
                // Save profile info (in memory)
                print("Profile saved")
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationBarTitle("Profile Settings", displayMode: .inline)
    }
}

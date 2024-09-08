import SwiftUI

struct HomeView: View {
    @State private var scaleEffect: CGFloat = 1.0

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()

                // Welcome text
                Text("Welcome back to Civic Mate!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 10))

                // Navigation buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: CivicEducationView()) {
                        HomeButton(title: "Civic Education Hub", color: .blue, iconName: "book.fill")
                    }

                    NavigationLink(destination: CivicEngagementView()) {
                        HomeButton(title: "Civic Engagement Portal", color: .green, iconName: "megaphone.fill")
                    }

                    NavigationLink(destination: GovernmentServiceAssistantView()) {
                        HomeButton(title: "Government Services", color: .orange, iconName: "building.columns.fill")
                    }
                }
                .scaleEffect(scaleEffect)
                .onTapGesture {
                    withAnimation(.spring()) {
                        scaleEffect = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            scaleEffect = 1.0
                        }
                    }
                }

                Spacer()

                // Logout button
                Button(action: {
                    // Add logout logic
                }) {
                    Text("Logout")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .background(Image("home-background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

struct HomeButton: View {
    let title: String
    let color: Color
    let iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))

            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
    }
}


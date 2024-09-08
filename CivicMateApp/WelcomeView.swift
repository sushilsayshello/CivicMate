import SwiftUI

struct WelcomeView: View {
    @State private var isActive = false  // Track if the button is pressed

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Custom logo
                Image("civiclog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 50)

                // Welcome text with animation
                Text("Welcome to Civic Mate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.scale)
                    .shadow(radius: 5)

                Text("Your gateway to civic engagement and government services.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                // "Get Started" button
                NavigationLink(destination: LoginView(), isActive: $isActive) {
                    EmptyView()  // Invisible NavigationLink
                }

                Button(action: {
                    withAnimation {
                        isActive = true
                    }
                }) {
                    Text("Get Started")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title2)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                }

                Spacer()
            }
            .background(Image("welcome-background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all))
        }
    }
}

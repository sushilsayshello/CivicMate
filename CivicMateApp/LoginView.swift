import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful = false  // Used for navigation trigger

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Logo at the top
                Image("civiclog")  // Replace with your logo's name in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)  // Adjust the size of the logo as needed
                    .padding(.bottom, 50)

                Text("Login to Civic Mate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()

                // Username input field
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Password input field
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Login button
                NavigationLink(destination: HomeView(), isActive: $isLoginSuccessful) {
                    EmptyView()  // Invisible view for navigation
                }

                Button(action: {
                    // Simulating successful login regardless of the inputs
                    isLoginSuccessful = true
                }) {
                    Text("Login")
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

                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        // Placeholder for sign-up logic
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
        }
    }
}


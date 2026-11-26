
import SwiftUI

struct OnboardingView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userName") private var userName = ""
    @AppStorage("userEmail") private var userEmail = ""

    @State private var name = ""
    @State private var email = ""

    var body: some View {
        VStack(spacing: 22) {
            Text("LITTLE LEMON")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)

            Text("Welcome to Little Lemon")
                .font(.title2)
                .bold()

            Text("Discover delicious meals and order your favorites.")

            TextField("Your full name", text: $name)
                .textFieldStyle(.roundedBorder)

            TextField("Your email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)

            Button("Get Started") {
                userName = name
                userEmail = email
                isLoggedIn = true
            }
            .disabled(name.isEmpty || !email.contains("@"))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

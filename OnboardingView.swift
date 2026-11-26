
import SwiftUI

struct OnboardingView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userName") private var userName = ""
    @AppStorage("userEmail") private var userEmail = ""

    @State private var currentPage = 0
    @State private var name = ""
    @State private var email = ""

    private let titles = [
        "Welcome to Little Lemon",
        "Discover Our Menu",
        "Let's Get Started"
    ]

    private let descriptions = [
        "Enjoy a fresh and delicious Mediterranean food experience.",
        "Explore our meals, discover your favorites and search easily.",
        "Enter your details to create your personal profile."
    ]

    var body: some View {
        VStack(spacing: 25) {
            Text("LITTLE LEMON")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)

            TabView(selection: $currentPage) {
                ForEach(0..<3, id: \.self) { page in
                    VStack(spacing: 20) {
                        Image(systemName: [
                            "fork.knife",
                            "menucard",
                            "person.crop.circle"
                        ][page])
                        .font(.system(size: 65))
                        .foregroundColor(.orange)

                        Text(titles[page])
                            .font(.title2)
                            .bold()

                        Text(descriptions[page])
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)

                        if page == 2 {
                            TextField("Full Name", text: $name)
                                .textFieldStyle(.roundedBorder)

                            TextField("Email Address", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                        }
                    }
                    .padding()
                    .tag(page)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            Button {
                if currentPage < 2 {
                    currentPage += 1
                } else {
                    userName = name
                    userEmail = email
                    isLoggedIn = true
                }
            } label: {
                Text(currentPage < 2 ? "Next" : "Get Started")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(
                currentPage == 2 &&
                (name.trimmingCharacters(in: .whitespaces).isEmpty ||
                 !email.contains("@"))
            )
        }
        .padding()
    }
}

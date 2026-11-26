
import SwiftUI

struct ProfileView: View {
    @AppStorage("userName") private var userName = ""
    @AppStorage("userEmail") private var userEmail = ""
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @State private var editedName = ""
    @State private var editedEmail = ""
    @State private var showSavedMessage = false

    var body: some View {
        Form {
            Section("Personal Information") {
                TextField("Full Name", text: $editedName)

                TextField("Email Address", text: $editedEmail)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section {
                Button("Save Changes") {
                    userName = editedName
                    userEmail = editedEmail
                    showSavedMessage = true
                }
                .disabled(
                    editedName.trimmingCharacters(in: .whitespaces).isEmpty ||
                    !editedEmail.contains("@")
                )

                if showSavedMessage {
                    Text("Your profile has been updated.")
                        .foregroundColor(.green)
                }
            }

            Section {
                Button(role: .destructive) {
                    userName = ""
                    userEmail = ""
                    isLoggedIn = false
                } label: {
                    Text("Log Out")
                }
            }
        }
        .navigationTitle("My Profile")
        .onAppear {
            editedName = userName
            editedEmail = userEmail
        }
    }
}

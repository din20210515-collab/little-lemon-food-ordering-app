
import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userName") private var userName = ""
    @AppStorage("userEmail") private var userEmail = ""

    var body: some View {
        NavigationStack {
            if isLoggedIn {
                HomeView()
            } else {
                OnboardingView()
            }
        }
    }
}

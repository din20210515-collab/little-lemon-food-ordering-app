
import SwiftUI

struct HomeView: View {
    @AppStorage("userName") private var userName = ""

    @State private var searchText = ""
    @State private var selectedCategory = "All"

    private let categories = [
        "All",
        "Starters",
        "Mains",
        "Desserts",
        "Drinks"
    ]

    private var filteredItems: [MenuItem] {
        MenuItem.sampleItems.filter { item in

            let matchesCategory =
                selectedCategory == "All" ||
                item.category == selectedCategory

            let matchesSearch =
                searchText.isEmpty ||
                item.name.localizedCaseInsensitiveContains(searchText) ||
                item.description.localizedCaseInsensitiveContains(searchText)

            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("LITTLE LEMON")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.orange)

                        Text("Welcome, \(userName)!")
                            .font(.subheadline)
                    }

                    Spacer()

                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                    }
                }

                // Restaurant Information
                VStack(alignment: .leading, spacing: 10) {
                    Text("Little Lemon Restaurant")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)

                    Text(
                        "Discover delicious Mediterranean food made fresh for you."
                    )
                    .foregroundColor(.white)

                    Text("Order your favorite meal today!")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .background(
                    Color(
                        red: 0.15,
                        green: 0.25,
                        blue: 0.30
                    )
                )
                .cornerRadius(15)

                // Search
                TextField(
                    "Search for food...",
                    text: $searchText
                )
                .textFieldStyle(.roundedBorder)

                // Categories
                Text("Food Categories")
                    .font(.title2)
                    .bold()

                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedCategory == category
                                        ? Color.orange
                                        : Color.gray.opacity(0.2)
                                    )
                                    .foregroundColor(
                                        selectedCategory == category
                                        ? .white
                                        : .primary
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                }

                // Menu
                Text("Our Menu")
                    .font(.title2)
                    .bold()

                ForEach(filteredItems) { item in
                    HStack(spacing: 15) {

                        Image(systemName: "fork.knife")
                            .font(.system(size: 30))
                            .foregroundColor(.orange)
                            .frame(width: 55, height: 55)
                            .background(
                                Color.orange.opacity(0.12)
                            )
                            .cornerRadius(10)

                        VStack(
                            alignment: .leading,
                            spacing: 5
                        ) {
                            Text(item.name)
                                .font(.headline)

                            Text(item.description)
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text(
                                "$\(item.price, specifier: "%.2f")"
                            )
                            .bold()
                            .foregroundColor(.orange)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(
                        Color.gray.opacity(0.1)
                    )
                    .cornerRadius(12)
                }

                // Empty Search Result
                if filteredItems.isEmpty {
                    Text("No meals found.")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

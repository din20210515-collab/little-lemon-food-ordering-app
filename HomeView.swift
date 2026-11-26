
import SwiftUI

struct HomeView: View {
    @AppStorage("userName") private var userName = ""

    @State private var searchText = ""
    @State private var selectedCategory = "All"

    private let categories = [
        "All", "Starters", "Mains", "Desserts", "Drinks"
    ]

    private let menuItems = [
        FoodItem(name: "Greek Salad", category: "Starters",
                 description: "Fresh vegetables, olives and feta cheese.",
                 price: 8.99, emoji: "🥗"),
        FoodItem(name: "Grilled Fish", category: "Mains",
                 description: "Fresh grilled fish with lemon.",
                 price: 15.99, emoji: "🐟"),
        FoodItem(name: "Pasta", category: "Mains",
                 description: "Pasta with a delicious tomato sauce.",
                 price: 12.99, emoji: "🍝"),
        FoodItem(name: "Lemon Dessert", category: "Desserts",
                 description: "A sweet and refreshing lemon dessert.",
                 price: 6.99, emoji: "🍋"),
        FoodItem(name: "Fresh Juice", category: "Drinks",
                 description: "Freshly squeezed seasonal juice.",
                 price: 4.99, emoji: "🥤")
    ]

    private var filteredItems: [FoodItem] {
        menuItems.filter { item in
            let matchesCategory =
                selectedCategory == "All" ||
                item.category == selectedCategory

            let matchesSearch =
                searchText.isEmpty ||
                item.name.localizedCaseInsensitiveContains(searchText)

            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                HStack {
                    VStack(alignment: .leading) {
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

                VStack(alignment: .leading, spacing: 10) {
                    Text("Little Lemon Restaurant")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)

                    Text("Discover delicious Mediterranean food made fresh for you.")
                        .foregroundColor(.white)

                    Text("Order your favorite meal today!")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 0.15, green: 0.25, blue: 0.30))
                .cornerRadius(15)

                TextField("Search for food...", text: $searchText)
                    .textFieldStyle(.roundedBorder)

                Text("Food Categories")
                    .font(.title2)
                    .bold()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
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
                                        ? .white : .primary
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                }

                Text("Our Menu")
                    .font(.title2)
                    .bold()

                ForEach(filteredItems) { item in
                    HStack(spacing: 15) {
                        Text(item.emoji)
                            .font(.system(size: 45))

                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.headline)

                            Text(item.description)
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("$\(item.price, specifier: "%.2f")")
                                .bold()
                                .foregroundColor(.orange)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }

                if filteredItems.isEmpty {
                    Text("No meals found.")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let description: String
    let price: Double
    let emoji: String
}

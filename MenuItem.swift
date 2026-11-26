import Foundation

struct MenuItem: Identifiable, Codable {
    var id: UUID
    var name: String
    var category: String
    var description: String
    var price: Double

    init(
        id: UUID = UUID(),
        name: String,
        category: String,
        description: String,
        price: Double
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.description = description
        self.price = price
    }

    static let sampleItems: [MenuItem] = [
        MenuItem(
            name: "Greek Salad",
            category: "Starters",
            description: "Fresh vegetables, olives and feta cheese.",
            price: 8.99
        ),
        MenuItem(
            name: "Grilled Fish",
            category: "Mains",
            description: "Fresh grilled fish served with lemon.",
            price: 15.99
        ),
        MenuItem(
            name: "Pasta",
            category: "Mains",
            description: "Pasta with tomato sauce.",
            price: 12.99
        ),
        MenuItem(
            name: "Lemon Dessert",
            category: "Desserts",
            description: "A refreshing lemon dessert.",
            price: 6.99
        ),
        MenuItem(
            name: "Fresh Juice",
            category: "Drinks",
            description: "Freshly squeezed seasonal juice.",
            price: 4.99
        )
    ]
}
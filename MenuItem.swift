
import Foundation

struct MenuItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var category: String
    var description: String
    var price: Double
}

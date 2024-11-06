import Foundation

typealias Countries = [Country]

struct Country: Codable, Identifiable, Equatable {

    let id: Int
    let coordinates: Coordinates
    let country: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case country
        case name
        case id = "_id"
    }

    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

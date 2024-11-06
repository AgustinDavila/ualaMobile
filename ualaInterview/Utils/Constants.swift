import Foundation

struct Constants { 
    static let bookmarks = "Bookmarks"
    static let countries = "Countries"
    static let filter = "Search countries"
    static let information = "Country Information"
    static let latitude = "Latitude"
    static let longitude = "Longitude"
    static let showInformation = "More information"

    static func title(country: Country) -> String {
        return "\(country.name), \(country.country)"
    }

    static func coordinates(country: Country) -> String {
        return "Lat: \(country.coordinates.lat). Lon: \(country.coordinates.lon)."
    }

    static let countryMock: Country = .init(
        id: 1,
        coordinates: .init(
            lon: 1,
            lat: 1
        ),
        country: "Test",
        name: "Test"
    )
}

extension Constants {
    struct Icons {
        static let bookmark = "bookmark"
        static let bookmarkFill = "bookmark.fill"
        static let close = "xmark"
    }
}

extension Constants {
    struct URL {
        static let countries = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    }
}

extension Constants {
    struct NetworkingClient {
        static let apiKeyHeader = "X-Api-Key"
        static let contentTypeHeader = ["Content-Type": "application/json"]
    }
    struct HTTPMethod {
        static let get = "GET"
    }
    struct NetworkError {
        static let badRequestDescription = "Bad Request (400): Unable to perform the request."
        static let badRequestTitle = "badRequestError"
        static let decodingDescription = "Unable to decode successfully."
        static let decodingTitle = "decodingError"
        static let forbiddenDescription = "Forbidden (403): You don't have permission to access this resource."
        static let forbiddenTitle = "forbiddenError"
        static let invalidResponseDescription = "Invalid response."
        static let invalidResponseTitle = "invalidResponse"
        static let notFoundDescription = "Not Found (404): The requested resource could not be found."
        static let notFoundTitle = "notFoundError"
        static let serverTitle = "serverError"
        static let typeDescription = "Another error type occurred"
        static let unauthorizedDescription = "Unauthorized (401): Authentication is required."
        static let unauthorizedtTitle = "unauthorizedError"
        static let unknownTitle = "unknownStatusCodeError"
        static func unknownDescription(statusCode: Int) -> String {
            return "Unknown error with status code: \(statusCode)."
        }
    }
}

extension Constants {
    struct Testing {
        static let country1 = Country(id: 1,coordinates: .init(lon: 1, lat: 1),country: "AR",name: "Mendoza")
        static let country2 = Country(id: 2,coordinates: .init(lon: 1, lat: 1),country: "AR",name: "Buenos Aires")
        static let country3 = Country(id: 3,coordinates: .init(lon: 1, lat: 1),country: "AR",name: "Cordoba")
        static let country4 = Country(id: 4,coordinates: .init(lon: 1, lat: 1),country: "ES",name: "Cordoba")
        static let country5 = Country(id: 5,coordinates: .init(lon: 1, lat: 1),country: "US",name: "Mendoza")
        static let country6 = Country(id: 6,coordinates: .init(lon: 1, lat: 1),country: "US",name: "Alabama")
        static let country7 = Country(id: 7,coordinates: .init(lon: 1, lat: 1),country: "US",name: "Albuquerque")
        static let country8 = Country(id: 8,coordinates: .init(lon: 1, lat: 1),country: "US",name: "Anaheim")
        static let country9 = Country(id: 9,coordinates: .init(lon: 1, lat: 1),country: "US",name: "Arizona")
        static let country10 = Country(id: 10,coordinates: .init(lon: 1, lat: 1),country: "AU",name: "Sydney")

        static let countries = [country1, country2, country3, country4, country5, country6, country7, country8, country9, country10]

    }
}

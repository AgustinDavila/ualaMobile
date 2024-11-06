import Foundation

class BookmarkManager {
    private static let BOOKMARKS_KEY = "bookmarks"
    private static let manager = UserDefaults.standard

    static func saveBookmarks(_ countries: Countries) throws {
        let data = try JSONEncoder().encode(countries)
        manager.set(data, forKey: BOOKMARKS_KEY)
    }

    static func loadBookmarks() throws -> Countries? {
        if let data = manager.data(forKey: BOOKMARKS_KEY) {
            let countries = try JSONDecoder().decode(Countries.self, from: data)
            return countries
        }

        return nil
    }
}

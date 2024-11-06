import Foundation
import SwiftUI
import MapKit

class CountryViewModel: ObservableObject {
    // MARK: - Observable Poperties
    @Published var isLoading = true
    @Published var bookmarkedCountries: Countries = []
    @Published var countriesList: Countries?
    @Published var selectedCountry: Country?
    @Published var prompt = ""
    @Published var showInformation = false
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())

    // MARK: - Private properties
    private var allCountries: Countries?
    private let repository = RemoteRepository.shared

    @MainActor
    func getCountries() async {
        if allCountries?.isEmpty == false {
            return
        }
        self.isLoading = true
        do {
            allCountries = try await repository.getCountries()
            countriesList = allCountries
        } catch let error as NetworkError {
            debugPrint(error.errorDescription ?? "")
        } catch {
            debugPrint(Constants.NetworkError.typeDescription)
        }
        self.isLoading = false
    }

    func filterCountries() {
        if prompt.isEmpty {
            countriesList = allCountries
        } else {
            countriesList = allCountries?.filter { $0.name.lowercased().hasPrefix(prompt.lowercased()) }
        }
    }

    func selectCountry(_ country: Country) {
        self.selectedCountry = country
        self.mapRegion = MapCameraPosition.region(
            MKCoordinateRegion(
                center: .init(latitude: country.coordinates.lat, longitude: country.coordinates.lon),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        )
    }

    func showMoreDetails() {
        self.showInformation = true
    }

    func loadBookmarks() {
        do {
            if let countries = try BookmarkManager.loadBookmarks() {
                bookmarkedCountries = countries
            }
        } catch let error {
            print(error)
        }
    }

    func bookmark(_ bookmark: Country) {
        if bookmarkedCountries.contains(where: { $0.id == bookmark.id }) {
            deleteBookmark(bookmark)
        } else {
            saveBookmark(bookmark)
        }
    }

    func saveBookmark(_ country: Country) {
        bookmarkedCountries.append(country)
        do {
            try BookmarkManager.saveBookmarks(bookmarkedCountries)
        } catch let error {
            print(error)
        }
    }

    func deleteBookmark(_ bookmark: Country) {
        bookmarkedCountries.removeAll { country in
            country.id == bookmark.id
        }
        do {
            try BookmarkManager.saveBookmarks(bookmarkedCountries)
        } catch let error {
            print(error)
        }
    }

    func isBookmarked(_ country: Country) -> Bool {
        return bookmarkedCountries.contains(where: { $0.id == country.id }) ? true : false
    }

    // Testing
    func loadAllCountries(_ countries: Countries) {
        self.allCountries = countries
    }
}

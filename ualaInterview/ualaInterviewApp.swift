import SwiftUI

@main
struct ualaInterviewApp: App {
    @StateObject var countryViewModel = CountryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(countryViewModel)
        }
    }
}

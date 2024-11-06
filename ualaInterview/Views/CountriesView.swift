import SwiftUI

struct CountriesView: View {
    @EnvironmentObject var countryViewModel: CountryViewModel
    @EnvironmentObject var router: Router
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var showFavourites = false

    var body: some View {
        NavigationView {
            if countryViewModel.isLoading {
                progressView
            } else {
                VStack {
                    ControlGroup {
                        showCountries
                        showBookmarks
                    }.padding(.horizontal)

                    if showFavourites == true {
                        bookmarkedCountries
                    } else {
                        allCountries
                    }
                }
            }
            CountryMapView()
        }
        .task {
            countryViewModel.loadBookmarks()
            await countryViewModel.getCountries()
        }
        .onChange(of: countryViewModel.prompt) { _,_ in
            countryViewModel.filterCountries()
        }
        .sheet(isPresented: $countryViewModel.showInformation) {
            CountryInformationView()
                .presentationDetents([.fraction(0.4)])
        }
        .searchable(text: $countryViewModel.prompt, prompt: Constants.filter)

    }

    var progressView: some View {
        ProgressView()
    }

    var showCountries: some View {
        Button(Constants.countries) {
            showFavourites = false
        }
    }

    var showBookmarks: some View {
        Button(Constants.bookmarks) {
            showFavourites = true
        }
    }

    var allCountries: some View {
        List(countryViewModel.countriesList ?? []) { country in
            CountryCardView(country: country)
                .onTapGesture {
                    if horizontalSizeClass == .regular && verticalSizeClass == .compact {
                        countryViewModel.selectCountry(country)
                    } else {
                        countryViewModel.selectCountry(country)
                        router.navigateTo(.countryMapView)
                    }
                }
        }
    }

    var bookmarkedCountries: some View {
        List(countryViewModel.prompt.isEmpty ?
             countryViewModel.bookmarkedCountries :
                countryViewModel.bookmarkedCountries.filter { $0.name.lowercased().hasPrefix(countryViewModel.prompt.lowercased()) }
        ) { country in
            CountryCardView(country: country)
                .onTapGesture {
                    if horizontalSizeClass == .regular && verticalSizeClass == .compact {
                        countryViewModel.selectCountry(country)
                    } else {
                        countryViewModel.selectCountry(country)
                        router.navigateTo(.countryMapView)
                    }
                }
        }
    }
}

#Preview {
    CountriesView()
}

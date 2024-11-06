import SwiftUI

struct CountryCardView: View {
    @EnvironmentObject var countryViewModel: CountryViewModel
    let country: Country

    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(Constants.title(country: country))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text(Constants.coordinates(country: country))
                    .fontWeight(.ultraLight)
                Button {
                    countryViewModel.selectCountry(country)
                    countryViewModel.showMoreDetails()
                } label: {
                    Text(Constants.showInformation)
                        .foregroundStyle(.blue)
                }
            }

            Spacer()

            Button(action: {
                countryViewModel.bookmark(country)
            }, label: {
                if countryViewModel.isBookmarked(country) {
                    bookmarkFill
                } else {
                    bookmark
                }
            })
        }.buttonStyle(.plain)
    }

    var bookmark: some View {
        Image(systemName: Constants.Icons.bookmark)
    }

    var bookmarkFill: some View {
        Image(systemName: Constants.Icons.bookmarkFill)
            .renderingMode(.template)
            .foregroundStyle(.blue)
    }
}

#Preview {
    CountryCardView(country: Constants.countryMock)
        .padding()
        .environmentObject(CountryViewModel())
}

import SwiftUI

struct CountryInformationView: View {
    @EnvironmentObject var countryViewModel: CountryViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 32) {
            title
            countryName
            coordinates
            Spacer()
        }
        .padding(16)
        .overlay(alignment: .topTrailing) {
            close
                .padding(4)
                .onTapGesture {
                    dismiss()
                }
        }

    }

    var title: some View {
        Text(Constants.information)
            .font(.title)
            .fontWeight(.bold)
    }

    var countryName: some View {
        VStack {
            Text(countryViewModel.selectedCountry?.name ?? "")
                .font(.headline)
                .fontWeight(.bold)
            Text(countryViewModel.selectedCountry?.country ?? "")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
    }

    var coordinates: some View {
        HStack {
            VStack {
                Text(Constants.latitude)
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("\(countryViewModel.selectedCountry?.coordinates.lat ?? 0)")
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )

            VStack {
                Text(Constants.longitude)
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("\(countryViewModel.selectedCountry?.coordinates.lon ?? 0)")
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
        }
    }

    var close: some View {
        Image(systemName: Constants.Icons.close)
    }
}

#Preview {
    CountryInformationView()
}

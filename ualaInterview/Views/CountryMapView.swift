import SwiftUI
import MapKit

struct CountryMapView: View {
    @EnvironmentObject var countryViewModel: CountryViewModel

    var body: some View {
        Map(position: $countryViewModel.mapRegion)
    }
}

#Preview {
    CountryMapView()
}

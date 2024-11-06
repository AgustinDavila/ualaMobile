import Foundation
import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable {
        case countryMapView
    }

    @Published var path: NavigationPath = NavigationPath()

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .countryMapView:
            CountryMapView()
        }
    }

    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }

    func navigateBack() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

import Foundation

class RemoteRepository {

    static let shared = RemoteRepository()

    private let client: NetworkingClient

    init(client: NetworkingClient = NetworkingClient(session: URLSession.shared)) {
        self.client = client
    }

    // MARK: - CountriesView
    func getCountries() async throws -> Countries? {
        guard let url = URL(string: Constants.URL.countries) else { return nil }

        let resource = Resource(url: url, method: .get, modelType: Countries.self)

        let data = try await client.load(resource)

        let orderedCountries = data.sorted { $0.name < $1.name }

        return orderedCountries
    }
}

import Foundation

class NetworkingClient {
    private let session: URLSession

    init(session: URLSession) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Constants.NetworkingClient.contentTypeHeader
        self.session = session
    }

    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {

        var request = URLRequest(url: resource.url)

        switch resource.method {
            case .get:
                let components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                guard let url = components?.url else {
                    throw NetworkError.badRequest
                }
                request.url = url
        }

        request.setValue("", forHTTPHeaderField: Constants.NetworkingClient.apiKeyHeader)

        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
            case 200...299:
                break
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.unknownStatusCode(httpResponse.statusCode)
        }

        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

extension NetworkingClient {
    static var development: NetworkingClient {
        return NetworkingClient(session: URLSession.shared)
    }
}

class NetworkingClientMock: NetworkingClient {
    var result: Any?
    var error: Error?

    init(result: Any? = nil, error: Error? = nil) {
        self.result = result
        self.error = error
        super.init(session: URLSession.shared)
    }

    override func load<T>(_ resource: Resource<T>) async throws -> T where T: Decodable {
        if let error = error {
            throw error
        }
        return result as! T
    }
}

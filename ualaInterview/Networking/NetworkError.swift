import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError(String)
    case decodingError(Error)
    case invalidResponse
    case unknownStatusCode(Int)
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
            case .badRequest:
            return NSLocalizedString(Constants.NetworkError.badRequestDescription, comment: Constants.NetworkError.badRequestTitle)
            case .unauthorized:
            return NSLocalizedString(Constants.NetworkError.unauthorizedDescription, comment: Constants.NetworkError.unauthorizedtTitle)
            case .forbidden:
            return NSLocalizedString(Constants.NetworkError.forbiddenDescription, comment: Constants.NetworkError.forbiddenTitle)
            case .notFound:
            return NSLocalizedString(Constants.NetworkError.notFoundDescription, comment: Constants.NetworkError.notFoundTitle)
            case .serverError(let errorMessage):
            return NSLocalizedString(errorMessage, comment: Constants.NetworkError.serverTitle)
            case .decodingError(let error):
            print(error)
            return NSLocalizedString(Constants.NetworkError.decodingDescription, comment: Constants.NetworkError.decodingTitle)
            case .invalidResponse:
            return NSLocalizedString(Constants.NetworkError.invalidResponseDescription, comment: Constants.NetworkError.invalidResponseTitle)
            case .unknownStatusCode(let statusCode):
            return NSLocalizedString(Constants.NetworkError.unknownDescription(statusCode: statusCode), comment: Constants.NetworkError.unknownTitle)
        }
    }
}

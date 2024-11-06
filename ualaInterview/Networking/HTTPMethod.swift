import Foundation

enum HTTPMethod {
    case get

    var name: String {
        switch self {
            case .get:
                return Constants.HTTPMethod.get
        }
    }
}

import Foundation

public struct RequestBrandsFilters {
    public enum Gender: Int {
        case woman = 0
        case man = 1
        case unisex = 2
        case kids = 3
    }

    public let gender: Gender?

    public var params: [String: String] {
        var params: [String: String] = [:]
        if let gender = gender {
            params[Keys.gender.rawValue] = String(gender.rawValue)
        }

        return params
    }

    public init(gender: Gender?) {
        self.gender = gender
    }
}

private extension RequestBrandsFilters {
    enum Keys: String {
        case gender
    }
}

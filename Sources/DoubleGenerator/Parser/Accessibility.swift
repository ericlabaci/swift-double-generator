import Foundation

enum Accessibility: String, Codable, UnknownCaseRepresentable {
    static var unknownCase: Accessibility = .unknown

    case `public` = "source.lang.swift.accessibility.public"
    case `private` = "source.lang.swift.accessibility.private"
    case `fileprivate` = "source.lang.swift.accessibility.fileprivate"
    case `internal` = "source.lang.swift.accessibility.internal"
    case unknown

    var tag: String {
        let value: String
        switch self {
        case .public:
            value = "public"
        case .private:
            value = "private"
        case .fileprivate:
            value = "fileprivate"
        case .internal:
            value = ""
        case .unknown:
            value = ""
        }
        return (self != .unknown || self != .internal) ? "\(value) " : value
    }
}

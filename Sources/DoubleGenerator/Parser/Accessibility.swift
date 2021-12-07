import Foundation

enum Accessibility: String, Codable, UnknownCaseRepresentable {
    static var unknownCase: Accessibility = .unknown

    case `public` = "source.lang.swift.accessibility.public"
    case `private` = "source.lang.swift.accessibility.private"
    case `fileprivate` = "source.lang.swift.accessibility.fileprivate"
    case `internal` = "source.lang.swift.accessibility.internal"
    case unknown
}

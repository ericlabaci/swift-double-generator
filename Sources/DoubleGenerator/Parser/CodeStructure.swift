import Foundation

struct CodeStructure: Decodable {
    let substructures: [Substructure]

    enum CodingKeys: String, CodingKey {
        case substructures = "key.substructure"
    }
}

struct Substructure: Decodable {
    let kind: Kind
    let accessibility: Accessibility?
    let name: String?
    let typename: String?
    let setterAccessibility: Accessibility?
    let substructures: [Substructure]?

    enum CodingKeys: String, CodingKey {
        case kind = "key.kind"
        case accessibility = "key.accessibility"
        case name = "key.name"
        case typename = "key.typename"
        case substructures = "key.substructure"
        case setterAccessibility = "key.setter_accessibility"
    }
}


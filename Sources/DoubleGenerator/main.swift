import ArgumentParser
import Foundation
import SourceKittenFramework

struct Double: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to auto generate doubles",
        subcommands: [Generate.self])

    init() { }
}

Double.main()

struct Generate: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate doubles for protocols")

    @Argument(help: "The path of the file containing the protocols")
    private var path: String

    func run() throws {
        print("Creating a double for file \"\(path)\"")

        let file = File(path: path)!

        let structure = try! Structure(file: file)

        let data = structure.description.data(using: .utf8)
        let x = try! JSONDecoder().decode(MyStructure.self, from: data!)

        x.printInformation()
    }
}

struct MyStructure: Decodable {
    struct Substructure: Decodable {
        enum Kind: String, Decodable, UnknownCaseRepresentable {
            static var unknownCase: Kind = .unknown

            case instance = "source.lang.swift.decl.function.method.instance"
            case parameter = "source.lang.swift.decl.var.parameter"
            case `protocol` = "source.lang.swift.decl.protocol"
            case unknown
        }

        let kind: Kind
        let name: String?
        let typename: String?
        let substructures: [Substructure]?

        enum CodingKeys: String, CodingKey {
            case kind = "key.kind"
            case name = "key.name"
            case typename = "key.typename"
            case substructures = "key.substructure"
        }
    }

    let substructures: [Substructure]

    enum CodingKeys: String, CodingKey {
        case substructures = "key.substructure"
    }
}

extension MyStructure {
    func printInformation() {
        substructures.forEach { sub in
            sub.printInformation(level: 1)
        }
    }
}

extension MyStructure.Substructure {
    func printInformation(level: Int) {
        Printer.print("Name \(name ?? "No name for kind") of kind \(kind) and type \(typename ?? "No type")", with: level)
        if let substructures = substructures {
            substructures.forEach { sub in
                sub.printInformation(level: level + 1)
            }
        } else {
            Printer.print("No substructures", with: level + 1)
        }
    }
}

final class Printer {
    static func print(_ message: String, with level: Int) {
        let whitespaces = Array(1...level).map { _ in "  " }.joined()

        Swift.print("\(whitespaces)\(message)")
    }
}

public protocol UnknownCaseRepresentable: RawRepresentable, CaseIterable where RawValue: Equatable & Codable {
    static var unknownCase: Self { get }
}

public extension UnknownCaseRepresentable {
    init(rawValue: RawValue) {
        let value = Self.allCases.first { $0.rawValue == rawValue }
        self = value ?? Self.unknownCase
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        let value = Self(rawValue: rawValue)
        self = value ?? Self.unknownCase
    }
}

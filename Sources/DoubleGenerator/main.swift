import ArgumentParser
import Foundation
import SourceKittenFramework
import Stencil

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
        let codeStructure = try! JSONDecoder().decode(CodeStructure.self, from: data!)

        let firstProtocol = codeStructure.substructures.first(where: { $0.kind == .protocol })!
        let protocolStructure = ProtocolStructure(protocolStructure: firstProtocol)
        let protocolStencil = ProtocolStencil(protocolStructure: protocolStructure)

        let environment = Environment(loader: FileSystemLoader(paths: ["./Sources"]))

        do {
            let content = try environment.renderTemplate(name: "template.stencil", context: ["protocol": protocolStencil])
            print(content)
        } catch {
            print(error)
        }

    }
}

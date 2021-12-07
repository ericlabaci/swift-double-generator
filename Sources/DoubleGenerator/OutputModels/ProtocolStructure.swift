import Foundation

struct ProtocolStructure {
    let name: String
    let variables: [VariableStructure]
    let functions: [FunctionStructure]

    init(protocolStructure: Substructure) {
        self.name = protocolStructure.name ?? ""
        var variables: [VariableStructure] = []
        var functions: [FunctionStructure] = []
        if let substructures = protocolStructure.substructures {
            for substruct in substructures {
                switch substruct.kind {
                case .functionMethodInstance:
                    functions.append(FunctionStructure(functionSubstructure: substruct))
                case .varInstance:
                    variables.append(VariableStructure(variableStructure: substruct))
                default:
                    break
                }
            }
        }
        self.variables = variables
        self.functions = functions
    }
}

struct VariableStructure {
    let name: String
    let returnType: String
    let setterAccessibility: Accessibility?

    init(variableStructure: Substructure) {
        self.name = variableStructure.name ?? ""
        self.returnType = variableStructure.typename ?? ""
        self.setterAccessibility = variableStructure.setterAccessibility
    }
}

struct FunctionStructure {
    let name: String
    let parameters: [Parameters]
    let returnType: String?

    init(functionSubstructure: Substructure) {
        if let functionName = functionSubstructure.name {
            var params: [Parameters] = []
            let (name, externalParametersName) = functionName.functionAttributes
            self.name = name
            if let substructures = functionSubstructure.substructures, !externalParametersName.isEmpty {
                let internalParametersName = substructures.map { $0.name ?? ""}
                let parametersType = substructures.map { $0.typename ?? ""}
                for i in 0..<externalParametersName.count {
                    params.append(
                        Parameters(
                            externalName: externalParametersName[i],
                            internalName: internalParametersName[i],
                            type: parametersType[i]
                        )
                    )
                }
                self.parameters = params
            } else {
                self.parameters = []
            }
            self.returnType = functionSubstructure.typename
        } else {
            self.name = functionSubstructure.name ?? ""
            self.parameters = []
            self.returnType = nil
        }
    }
}

struct Parameters {
    let externalName: String
    let internalName: String
    let type: String

    func getParam() -> String {
        if externalName == internalName {
            return "\(externalName): \(type)"
        } else {
            return "\(externalName) \(internalName): \(type)"
        }
    }
}

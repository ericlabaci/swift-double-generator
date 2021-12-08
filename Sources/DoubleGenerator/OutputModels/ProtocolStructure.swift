import Foundation

class ProtocolStructure {
    let name: String
    let accessibility: Accessibility?
    let variables: [VariableStructure]
    let functions: [FunctionStructure]

    init(protocolStructure: Substructure) {
        self.name = protocolStructure.name ?? ""
        self.accessibility = protocolStructure.accessibility
        var variables: [VariableStructure] = []
        var functions: [FunctionStructure] = []
        if let substructures = protocolStructure.substructures {
            for substructure in substructures {
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

class VariableStructure {
    let name: String
    let returnType: String
    let setterAccessibility: Accessibility?

    init(variableStructure: Substructure) {
        self.name = variableStructure.name ?? ""
        self.returnType = variableStructure.typename ?? ""
        self.setterAccessibility = variableStructure.setterAccessibility
    }
}

class FunctionStructure {
    let name: String
    let parameters: [Parameter]
    let returnType: String?

    init(functionSubstructure: Substructure) {
        if let functionName = functionSubstructure.name {
            var params: [Parameter] = []
            let (name, externalParametersName) = functionName.functionAttributes
            self.name = name
            if let substructures = functionSubstructure.substructures, !externalParametersName.isEmpty {
                let internalParametersName = substructures.map { $0.name ?? ""}
                let parametersType = substructures.map { $0.typename ?? ""}
                for i in 0..<externalParametersName.count {
                    params.append(
                        Parameter(
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

class Parameter {
    let externalName: String
    let internalName: String
    let type: String

    init(externalName: String, internalName: String, type: String) {
        self.externalName = externalName
        self.internalName = internalName
        self.type = type
    }
}

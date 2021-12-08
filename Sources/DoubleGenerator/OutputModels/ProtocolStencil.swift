import Foundation

class ProtocolStencil {
    let name: String
    let variables: [VariableStencil]
    let functions: [FunctionStencil]

    init(protocolStructure: ProtocolStructure) {
        self.name = protocolStructure.name
        self.variables = protocolStructure.variables.map(VariableStencil.init)
        self.functions = protocolStructure.functions.map(FunctionStencil.init)
    }
}

class VariableStencil {
    let name: String
    let returnType: String
    let setterAccessibility: Accessibility?

    init(variableStructure: VariableStructure) {
        self.name = variableStructure.name
        self.returnType = variableStructure.returnType
        self.setterAccessibility = variableStructure.setterAccessibility
    }
}

class FunctionStencil {
    let name: String
    let parameters: [ParameterStencil]
    //Recode the function structure
    let fullFunction: String
    let hasParams: Bool
    //Used in paramsPassed variable declaration
    let paramsList: String
    //Used inside function
    let paramsInternalNameList: String
    let hasReturn: Bool
    let returnType: String
    let isReturnOptional: Bool
    let hasClosure: Bool
    let closureParam: ParameterStencil?

    init(functionSubstructure: FunctionStructure) {
        self.name = functionSubstructure.name
        self.parameters = functionSubstructure.parameters.map(ParameterStencil.init)
        self.hasParams = !self.parameters.isEmpty

        let allParams = self.parameters.map { $0.fullParam }.joined(separator: ", ")
        if let type = functionSubstructure.returnType {
            self.fullFunction = "func \(functionSubstructure.name)(\(allParams)) -> \(type)"
        } else {
            self.fullFunction = "func \(functionSubstructure.name)(\(allParams))"
        }
        if hasParams {
            if self.parameters.count > 1 {
                self.paramsList = "(\(self.parameters.map { $0.internalOnlyParam }.joined(separator: ", ")))"
                self.paramsInternalNameList = "(\(self.parameters.map { $0.usualName }.joined(separator: ", ")))"
            } else {
                self.paramsList = self.parameters.map { $0.type }.joined()
                self.paramsInternalNameList = self.parameters.map { $0.usualName }.joined()
            }
        } else {
            self.paramsList = ""
            self.paramsInternalNameList = ""
        }
        self.hasReturn = functionSubstructure.returnType != nil
        self.returnType = functionSubstructure.returnType ?? ""
        self.isReturnOptional = self.returnType.isReturnOptional
        let closure = self.parameters.first { $0.type.removeEscapingIfNeeded.isClosureParameter }
        self.closureParam = closure
        self.hasClosure = self.closureParam != nil
    }
}

class ParameterStencil {
    let usualName: String
    let type: String
    let fullParam: String
    let internalOnlyParam: String

    init(parameter: Parameter) {
        self.usualName = parameter.internalName
        self.type = parameter.type.removeEscapingIfNeeded
        self.internalOnlyParam = "\(parameter.internalName): \(parameter.type.removeEscapingIfNeeded)"
        if parameter.externalName == parameter.internalName {
            self.fullParam = "\(parameter.internalName): \(parameter.type)"
        } else {
            self.fullParam = "\(parameter.externalName) \(parameter.internalName): \(parameter.type)"
        }
    }
}


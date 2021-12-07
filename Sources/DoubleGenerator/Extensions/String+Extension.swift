import Foundation

extension String {
    var functionAttributes: (String, [String]) {
        let parenthesesIndex = self.firstIndex(of: "(")!
        let finalParenthesesIndex = self.firstIndex(of: ")")!
        let funcName = String(self.prefix(upTo: parenthesesIndex))
        let parametersString = self[index(after: parenthesesIndex)..<finalParenthesesIndex]
        var allParams = parametersString.components(separatedBy: ":")
        allParams.removeLast()
        return (funcName, allParams)
    }
}

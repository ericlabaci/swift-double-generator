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

    var removeEscapingIfNeeded: String {
        return self.replacingOccurrences(of: "@escaping ", with: "")
    }

    var isReturnOptional: Bool {
        guard let lastChar = self.last else {
            return false
        }
        return lastChar == "?"
    }

    var isClosureParameter: Bool {
        let regex = try! NSRegularExpression(pattern: "(.*).*->")
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}

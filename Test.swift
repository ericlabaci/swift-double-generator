import Foundation

// MARK: - ChatProviderProtocol

final protocol ChatProviderProtocol {
    var foo: String { return "" }

    func markAsFinished(with conversationId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func foo(bar: String) -> Int
    func foo()
}

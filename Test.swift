import Foundation

// MARK: - ChatProviderProtocol

public final protocol ChatProviderProtocol {
    var foo: String { get set }

    func markAsFinished(with conversationId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func foo(bar: String) -> Int
    func foo()
}

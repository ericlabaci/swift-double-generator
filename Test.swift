import Foundation

// MARK: - ChatProviderProtocol

public protocol ChatProviderProtocol {
    func markAsFinished(conversationId: String, completion: @escaping (Result<Void, Error>) -> Void)

    func foo(bar: String) -> Int
}

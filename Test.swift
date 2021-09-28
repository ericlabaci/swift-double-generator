import Foundation

// MARK: - ChatProviderProtocol

public protocol ChatProviderProtocol {
    var chatId: String { get }
    var delegate: ChatProviderDelegate? { get set }

    func markAsFinished(conversationId: String, completion: @escaping (Result<Void, Error>) -> Void)

    func foo(bar: String) -> Int

    func bar() -> String?

    func replace(with string: String)
}

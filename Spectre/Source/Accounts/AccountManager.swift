import Combine

struct Account {
    let name: String
    let address: String
}

protocol AccountManagerProtocol {
    var currentAccount: CurrentValueSubject<Account, Never> { get }
    var allAccounts: [Account] { get }
}

final class AccountManager: AccountManagerProtocol {
    // MARK: - Private properties

    // MARK: - Lifecycle

    static let shared: AccountManagerProtocol = AccountManager()

    init() {
        let allAccounts: [Account] = [
            .init(name: "Transaction", address: "0x9f51B397ab942211ffC6587786BA9D419033D253"),
            .init(name: "Storage", address: "0x257a44560CEF651fb4C960faEa3abAd8367b9c8d")
        ]
        self.allAccounts = allAccounts
        currentAccount = .init(allAccounts.first!)
    }

    // MARK: - Conformance

    // MARK: AccountManagerProtocol

    let currentAccount: CurrentValueSubject<Account, Never>
    let allAccounts: [Account]
}

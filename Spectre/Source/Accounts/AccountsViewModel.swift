import SwiftUI

final class AccountsViewModel: ObservableObject {
    // MARK: - Private properties

    private let manager: AccountManagerProtocol

    // MARK: - Lifecycle

    init(manager: AccountManagerProtocol = AccountManager.shared) {
        self.manager = manager
    }

    // MARK: - Public

    var accountItems: [AccountItem] {
        manager.allAccounts.map {
            .init(account: $0, isCurrent: $0.address == manager.currentAccount.value.address)
        }
    }

    func selectAccount(with item: AccountItem) {
        guard let account = manager.allAccounts.first(where: { $0.address == item.id }) else {
            return
        }
        manager.currentAccount.value = account
    }
}

extension AccountsViewModel {
    struct AccountItem: Identifiable {
        let id: String
        let initial: String
        let name: String
        let truncatedAddress: String
        let isHighlighted: Bool

        init(account: Account, isCurrent: Bool) {
            id = account.address
            initial = String(account.name.prefix(1))
            name = account.name
            truncatedAddress = [account.address.prefix(4), account.address.suffix(4)].joined(separator: "...")
            isHighlighted = isCurrent
        }
    }
}

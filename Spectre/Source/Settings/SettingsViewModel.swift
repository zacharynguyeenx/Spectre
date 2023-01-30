import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    // MARK: - Private properties

    private let accountManager: AccountManagerProtocol
    @Published private var currentAccount: Account
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(accountManager: AccountManagerProtocol = AccountManager.shared) {
        self.accountManager = accountManager
        currentAccount = accountManager.currentAccount.value
    }

    // MARK: - Public

    var accountItem: AccountItem { .init(account: currentAccount) }

    let menus: [MenuItem] = [
        .init(title: "Address Book", value: nil),
        .init(title: "Display Language", value: "English"),
        .init(title: "Change Network", value: "Mainnet Beta"),
        .init(title: "Security & Privacy", value: nil),
        .init(title: "Redeem Beta Code", value: nil),
        .init(title: "Notifications", value: nil),
        .init(title: "Trusted Apps", value: nil),
        .init(title: "Preferred Explorer", value: "Solscan"),
        .init(title: "About Spectre", value: nil)
    ]

    func bind() {
        accountManager.currentAccount
            .sink { [weak self] in self?.currentAccount = $0 }
            .store(in: &cancellables)
    }
}

extension SettingsViewModel {
    struct AccountItem {
        let initial: String
        let name: String
        let truncatedAddress: String

        init(account: Account) {
            initial = String(account.name.prefix(1))
            name = account.name
            truncatedAddress = [account.address.prefix(4), account.address.suffix(4)]
                .joined(separator: "...")
        }
    }

    struct MenuItem: Identifiable {
        var id: String { title }
        let title: String
        let value: String?
    }
}

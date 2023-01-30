import SwiftUI

struct Account {
    let name: String
    let address: String
}

final class SettingsViewModel: ObservableObject {
    // MARK: - Private properties

    private let account = Account(
        name: "Transaction",
        address: "0x6c0678df4a51f5bfa50492070b17a90613d6eae2cda9d35084e13b04ab2cbd1d"
    )

    // MARK: - Lifecycle

    // MARK: - Public

    var accountItem: AccountItem { .init(account: account) }

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

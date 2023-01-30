import SwiftUI
import Combine

final class WalletViewModel: ObservableObject {
    // MARK: - Private properties

    private let walletService: WalletServiceProtocol
    private let accountManager: AccountManagerProtocol

    @Published private var currentAccount: Account
    @Published private var walletDetails: WalletDetails?
    private var cancellables = Set<AnyCancellable>()
    private let currencyCode = Locale.current.currency?.identifier ?? "USD"

    // MARK: - Lifecycle

    init(
        walletService: WalletServiceProtocol = WalletService(),
        accountManager: AccountManagerProtocol = AccountManager.shared
    ) {
        self.walletService = walletService
        self.accountManager = accountManager
        self.currentAccount = accountManager.currentAccount.value
    }

    // MARK: - Public

    var walletInitial: String { String(currentAccount.name.prefix(1)) }
    var walletName: String { currentAccount.name }
    var walletAddress: String {
        "(\(currentAccount.address.prefix(4))...\(currentAccount.address.suffix(4)))"
    }

    var totalBalance: String {
        walletDetails?.totalBalance.formatted(.currency(code: currencyCode)) ?? "-"
    }

    var totalBalanceChange: String {
        (walletDetails?.totalBalanceChange).map {
            [$0 > 0 ? "+" : nil, $0.formatted(.currency(code: currencyCode))].compactMap { $0 }.joined()
        } ?? "-"
    }

    var totalBalanceChangePercentage: String? {
        (walletDetails?.totalBalanceChangePercentage).map {
            [$0 > 0 ? "+" : nil, $0.formatted(), "%"].compactMap { $0 }.joined()
        }
    }

    var totalBalanceChangeColor: Color { (walletDetails?.totalBalanceChange).changeColor }

    var tokenItems: [TokenItem] {
        walletDetails?.tokens.map { TokenItem(token: $0, currencyCode: currencyCode) } ?? []
    }

    func bind() {
        accountManager.currentAccount.compactMap { [weak self] account in
            self?.walletDetails = nil
            self?.currentAccount = account
            return self?.walletService.getWalletDetails(address: account.address)
        }
        .switchToLatest()
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] in self?.walletDetails = $0 }
        )
        .store(in: &cancellables)
    }
}

struct TokenItem: Identifiable {
    var id: String { name }
    let icon: String
    let name: String
    let cryptoAmount: String
    let fiatAmount: String
    let fiatAmountChange: String
    let fiatAmountChangeColor: Color

    init(token: WalletDetails.Token, currencyCode: String) {
        icon = token.icon
        name = token.name
        cryptoAmount = [token.cryptoAmount.formatted(), token.symbol].joined(separator: " ")
        fiatAmount = token.fiatAmount.formatted(.currency(code: currencyCode))
        fiatAmountChange = [
            token.fiatAmountChange > 0 ? "+" : nil,
            token.fiatAmountChange.formatted(.currency(code: currencyCode))
        ].compactMap { $0 }.joined()
        fiatAmountChangeColor = token.fiatAmountChange.changeColor
    }
}

private extension Optional<Decimal> {
    var changeColor: Color {
        let change = self ?? 0
        if change > 0 {
            return .green
        } else if change < 0 {
            return .red
        } else {
            return .white
        }
    }
}

private extension Decimal {
    var changeColor: Color { Optional(self).changeColor }
}

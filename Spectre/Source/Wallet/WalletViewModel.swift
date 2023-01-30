import SwiftUI
import Combine

protocol WalletViewModelProtocol: ObservableObject {
    var walletInitial: String { get }
    var walletName: String { get }
    var walletAddress: String { get }
    var totalBalance: String { get }
    var totalBalanceChange: String { get }
    var totalBalanceChangePercentage: String { get }
    var totalBalanceChangeColor: Color { get }
    var tokenItems: [TokenItem] { get }

    func getWalletDetails()
}

final class WalletViewModel: WalletViewModelProtocol {
    // MARK: - Private properties

    private let service: WalletServiceProtocol
    @Published private var walletDetails: WalletDetails?
    private var cancellables = Set<AnyCancellable>()
    private let currencyCode = Locale.current.currency?.identifier ?? "USD"

    // MARK: - Lifecycle

    init(service: WalletServiceProtocol = WalletService()) {
        self.service = service
    }

    // MARK: - Conformance

    // MARK: WalletViewModelProtocol

    var walletInitial: String { (walletDetails?.name.prefix(1)).map(String.init) ?? "-" }

    var walletName: String { walletDetails?.name ?? "-" }

    var walletAddress: String {
        guard let address = walletDetails?.address else { return "(-)" }
        return "(\(address.prefix(4))...\(address.suffix(4)))"
    }

    var totalBalance: String {
        walletDetails?.totalBalance.formatted(.currency(code: currencyCode)) ?? "-"
    }

    var totalBalanceChange: String {
        walletDetails?.totalBalanceChange.formatted(.currency(code: currencyCode)) ?? "-"
    }

    var totalBalanceChangePercentage: String {
        (walletDetails?.totalBalanceChangePercentage).map { "\($0)%" } ?? "-"
    }

    var totalBalanceChangeColor: Color { (walletDetails?.totalBalanceChange).changeColor }

    var tokenItems: [TokenItem] {
        walletDetails?.tokens.map { TokenItem(token: $0, currencyCode: currencyCode) } ?? []
    }

    func getWalletDetails() {
        service.getWalletDetails(address: "0xAddReSS").sink(
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
        fiatAmountChange = token.fiatAmountChange.formatted(.currency(code: currencyCode))
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

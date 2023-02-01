import Foundation
import Combine

enum APIError: Error {
    case notFound
}

protocol WalletServiceProtocol {
    func getWalletDetails(address: String) -> AnyPublisher<WalletDetails, APIError>
}

struct WalletService: WalletServiceProtocol {
    func getWalletDetails(address: String) -> AnyPublisher<WalletDetails, APIError> {
        let wallet = WalletDetails.wallets.first { $0.address == address } ?? WalletDetails.wallets.first!

        return Just(wallet)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

struct WalletDetails {
    let address: String
    let totalBalance: Decimal
    let totalBalanceChange: Decimal
    let totalBalanceChangePercentage: Double
    let tokens: [Token]

    struct Token: Hashable {
        let name: String
        let icon: String
        let symbol: String
        let address: String
        let cryptoAmount: Decimal
        let fiatAmount: Decimal
        let fiatAmountChange: Decimal
    }
}

private extension WalletDetails {
    static var wallets: [WalletDetails] {
        [
            .init(
                address: "0x9f51B397ab942211ffC6587786BA9D419033D253",
                totalBalance: 8.11,
                totalBalanceChange: 0.24,
                totalBalanceChangePercentage: 3.02,
                tokens: [
                    .init(
                        name: "USD Coin",
                        icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png",
                        symbol: "USDC",
                        address: Stubs.usdcAddress,
                        cryptoAmount: 5.48195,
                        fiatAmount: 5.49,
                        fiatAmountChange: 0.01
                    ),
                    .init(
                        name: "Solana",
                        icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png",
                        symbol: "SOL",
                        address: Stubs.solAddress,
                        cryptoAmount: 0.09999,
                        fiatAmount: 2.65,
                        fiatAmountChange: 0.26
                    )
                ]
            ),
            .init(
                address: "0x257a44560CEF651fb4C960faEa3abAd8367b9c8d",
                totalBalance: 19018.474,
                totalBalanceChange: 5399.22,
                totalBalanceChangePercentage: 68.3,
                tokens: [
                    .init(
                        name: "Solana",
                        icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png",
                        symbol: "SOL",
                        address: Stubs.solAddress,
                        cryptoAmount: 110,
                        fiatAmount: 16560.5,
                        fiatAmountChange: 2033.124
                    ),
                    .init(
                        name: "Saber",
                        icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/11181.png",
                        symbol: "SBR",
                        address: Stubs.sbrAddress,
                        cryptoAmount: 11062.90,
                        fiatAmount: 1020.38,
                        fiatAmountChange: 224
                    ),
                    .init(
                        name: "Mango",
                        icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/11171.png",
                        symbol: "MNGO",
                        address: Stubs.mngoAddress,
                        cryptoAmount: 4239,
                        fiatAmount: 1002.947,
                        fiatAmountChange: 342.14
                    ),
                ]
            )
        ]
    }
}

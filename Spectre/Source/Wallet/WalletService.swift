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
        Just(WalletDetails.walletOne)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

struct WalletDetails {
    let name: String
    let address: String
    let totalBalance: Decimal
    let totalBalanceChange: Decimal
    let totalBalanceChangePercentage: Double
    let tokens: [Token]

    struct Token {
        let name: String
        let icon: String
        let symbol: String
        let cryptoAmount: Decimal
        let fiatAmount: Decimal
        let fiatAmountChange: Decimal
    }
}

private extension WalletDetails {
    static var walletOne: WalletDetails {
        .init(
            name: "Transaction",
            address: "0x6c0678df4a51f5bfa50492070b17a90613d6eae2cda9d35084e13b04ab2cbd1d",
            totalBalance: 8.11,
            totalBalanceChange: 0.24,
            totalBalanceChangePercentage: 3.02,
            tokens: [
                .init(
                    name: "USD Coin",
                    icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png",
                    symbol: "USDC",
                    cryptoAmount: 5.48195,
                    fiatAmount: 5.49,
                    fiatAmountChange: 0.01
                ),
                .init(
                    name: "Solana",
                    icon: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png",
                    symbol: "SOL",
                    cryptoAmount: 0.09999,
                    fiatAmount: 2.65,
                    fiatAmountChange: 0.26
                )
            ]
        )
    }
}

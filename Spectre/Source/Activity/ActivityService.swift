import Combine
import Foundation

protocol ActivityServiceProtocol {
    func getAllActivities() -> AnyPublisher<[Activity], Never>
}

struct ActivityService: ActivityServiceProtocol {
    let gstIcon = "https://s2.coinmarketcap.com/static/img/coins/64x64/16352.png"
    let usdcIcon = "https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png"

    func getAllActivities() -> AnyPublisher<[Activity], Never> {
        let activities: [Activity] = [
            .init(
                transactionType: .swap,
                senderAddress: "",
                receiverAddress: "",
                fungibleTokenTransfers: [
                    .init(tokenSymbol: "GST", tokenIcon: gstIcon, amount: -158.04999),
                    .init(tokenSymbol: "USDC", tokenIcon: usdcIcon, amount: 3.68146)
                ],
                isSuccess: true,
                fee: 0,
                appName: "Jupiter",
                timestamp: Date()
            ),
            .init(
                transactionType: .transferFungible,
                senderAddress: "",
                receiverAddress: "0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B",
                fungibleTokenTransfers: [
                    .init(tokenSymbol: "USDC", tokenIcon: usdcIcon, amount: -29.52355)
                ],
                isSuccess: true,
                fee: 0,
                appName: nil,
                timestamp: Date().addingTimeInterval(-86400)
            ),
            .init(
                transactionType: nil,
                senderAddress: "",
                receiverAddress: "",
                fungibleTokenTransfers: [],
                isSuccess: false,
                fee: 0,
                appName: "Jupiter",
                timestamp: Date().addingTimeInterval(-86400-1)
            ),
            .init(
                transactionType: nil,
                senderAddress: "",
                receiverAddress: "",
                fungibleTokenTransfers: [],
                isSuccess: true,
                fee: 0.000005,
                appName: nil,
                timestamp: Date().addingTimeInterval(-86400*2)
            ),
            .init(
                transactionType: .transferFungible,
                senderAddress: "0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B",
                receiverAddress: "",
                fungibleTokenTransfers: [
                    .init(tokenSymbol: "GST", tokenIcon: gstIcon, amount: 36.19998)
                ],
                isSuccess: true,
                fee: 0,
                appName: nil,
                timestamp: Date().addingTimeInterval(-86400*2-1)
            ),
        ]

        return Just(activities)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

struct Activity {
    let transactionType: TransactionType?
    let senderAddress: String
    let receiverAddress: String
    let fungibleTokenTransfers: [FungibleTokenTransfer]
    let isSuccess: Bool
    let fee: Decimal
    let appName: String?
    let timestamp: Date

    enum TransactionType: String {
        case swap
        case transferFungible
    }

    struct FungibleTokenTransfer {
        let tokenSymbol: String
        let tokenIcon: String
        let amount: Decimal
    }
}

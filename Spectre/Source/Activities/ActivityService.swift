import Combine
import Foundation

protocol ActivityServiceProtocol {
    func getAllActivities() -> AnyPublisher<[Activity], Never>
    func getActivitiesForToken(with address: String) -> AnyPublisher<[Activity], Never>
}

struct ActivityService: ActivityServiceProtocol {
    func getAllActivities() -> AnyPublisher<[Activity], Never> {
        Just(Stubs.activities)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func getActivitiesForToken(with address: String) -> AnyPublisher<[Activity], Never> {
        let activities = Stubs.activities
            .filter { $0.fungibleTokenTransfers.map(\.tokenAddress).contains(address) }
        return Just(activities)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

struct Activity: Identifiable {
    let id = UUID()
    let transactionType: TransactionType?
    let senderAddress: String
    let receiverAddress: String
    let fungibleTokenTransfers: [FungibleTokenTransfer]
    let isSuccess: Bool
    let fee: Decimal
    let provider: String?
    let providerIcon: String?
    let timestamp: Date

    init(
        transactionType: Activity.TransactionType?,
        senderAddress: String,
        receiverAddress: String,
        fungibleTokenTransfers: [Activity.FungibleTokenTransfer],
        isSuccess: Bool,
        fee: Decimal,
        provider: String? = nil,
        providerIcon: String? = nil,
        timestamp: Date
    ) {
        self.transactionType = transactionType
        self.senderAddress = senderAddress
        self.receiverAddress = receiverAddress
        self.fungibleTokenTransfers = fungibleTokenTransfers
        self.isSuccess = isSuccess
        self.fee = fee
        self.provider = provider
        self.providerIcon = providerIcon
        self.timestamp = timestamp
    }

    enum TransactionType: String {
        case swap
        case transferFungible
    }

    struct FungibleTokenTransfer {
        let tokenAddress: String
        let tokenSymbol: String
        let tokenIcon: String
        let amount: Decimal
    }
}

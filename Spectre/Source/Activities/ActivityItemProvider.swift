import Foundation
import SwiftUI

protocol ActivityItem: Identifiable {
    var id: UUID { get }
    var actionName: String { get }
    var activity: Activity { get }
}

struct SwapActivityItem: ActivityItem {
    let id = UUID()
    let activity: Activity
    let fromTokenIcon: String
    let toTokenIcon: String
    let actionName: String
    let description: String
    let toAmount: String
    let fromAmount: String
}

struct TokenTransferActivityItem: ActivityItem {
    let id = UUID()
    let activity: Activity
    let tokenIcon: String
    let actionIcon: String
    let actionIconColor: Color
    let actionName: String
    let address: String
    let amount: String
    let amountColor: Color
}

struct GenericActivityItem: ActivityItem {
    let id = UUID()
    let activity: Activity
    let isSuccess: Bool
    let actionName: String
    let provider: String?
    let value: String
}

protocol ActivityItemProviderProtocol {
    func item(for activity: Activity) -> any ActivityItem
}

struct ActivityItemProvider: ActivityItemProviderProtocol {
    func item(for activity: Activity) -> any ActivityItem {
        let genericItem = GenericActivityItem(
            activity: activity,
            isSuccess: activity.isSuccess,
            actionName: "App Interaction",
            provider: activity.provider,
            value: activity.isSuccess ? "\(activity.fee.formatted()) SOL" : "Failed"
        )

        switch activity.transactionType {
        case .transferFungible:
            guard let transfer = activity.fungibleTokenTransfers.first else { return genericItem }
            let isReceiving = transfer.amount > 0
            let address = isReceiving ? activity.senderAddress : activity.receiverAddress
            let truncatedAddress = [address.prefix(4), address.suffix(4)].joined(separator: "...")
            return TokenTransferActivityItem(
                activity: activity,
                tokenIcon: transfer.tokenIcon,
                actionIcon: isReceiving ? "arrow.down" : "paperplane.fill",
                actionIconColor: isReceiving ? .lavenderBlue : .rockmanBlue,
                actionName: isReceiving ? "Received" : "Sent",
                address: [isReceiving ? "From" : "To", truncatedAddress].joined(separator: ": "),
                amount: "\(isReceiving ? "+" : "-")\(abs(transfer.amount).formatted()) \(transfer.tokenSymbol)",
                amountColor: isReceiving ? .green : .white
            )

        case .swap:
            guard let fromTransfer = activity.fungibleTokenTransfers.first(where: { $0.amount < 0 }),
                  let toTransfer = activity.fungibleTokenTransfers.first(where: { $0.amount > 0 }) else {
                return genericItem
            }
            return SwapActivityItem(
                activity: activity,
                fromTokenIcon: fromTransfer.tokenIcon,
                toTokenIcon: toTransfer.tokenIcon,
                actionName: ["Swap", activity.provider].compactMap { $0 }.joined(separator: " on "),
                description: "\(fromTransfer.tokenSymbol) → \(toTransfer.tokenSymbol)",
                toAmount: "+\(abs(toTransfer.amount).formatted()) \(toTransfer.tokenSymbol)",
                fromAmount: "-\(abs(fromTransfer.amount).formatted()) \(fromTransfer.tokenSymbol)"
            )

        case .none:
            return genericItem
        }
    }
}


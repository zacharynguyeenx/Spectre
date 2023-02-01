import SwiftUI

struct ActivityDetailsViewItem {
    let navigationTitle: String
    let tokenIcons: [String]
    let statusIcon: String?
    let statusIconColor: Color?
    let actionIcon: String?
    let actionIconBackgroundColor: Color?
    let title: String?
    let titleColor: Color?
    let description: String?
    let generalDetails: [Details]
    let swapDetails: [Details]

    init(
        navigationTitle: String,
        tokenIcons: [String] = [],
        statusIcon: String? = nil,
        statusIconColor: Color? = nil,
        actionIcon: String? = nil,
        actionIconBackgroundColor: Color? = nil,
        title: String? = nil,
        titleColor: Color? = nil,
        description: String? = nil,
        generalDetails: [Details],
        swapDetails: [Details] = []
    ) {
        self.navigationTitle = navigationTitle
        self.tokenIcons = tokenIcons
        self.statusIcon = statusIcon
        self.statusIconColor = statusIconColor
        self.actionIcon = actionIcon
        self.actionIconBackgroundColor = actionIconBackgroundColor
        self.title = title
        self.titleColor = titleColor
        self.description = description
        self.generalDetails = generalDetails
        self.swapDetails = swapDetails
    }

    init(activity: Activity) {
        let genericItem = Self.genericItem(with: activity)
        switch activity.transactionType {
        case .swap: self = Self.swapItem(with: activity) ?? genericItem
        case .transferFungible: self = Self.transferItem(with: activity) ?? genericItem
        case .none: self = genericItem
        }
    }

    static func swapItem(with activity: Activity) -> Self? {
        guard let fromTransfer = activity.fungibleTokenTransfers.first(where: { $0.amount < 0 }),
              let toTransfer = activity.fungibleTokenTransfers.first(where: { $0.amount > 0 }) else {
            return nil
        }
        return .init(
            navigationTitle: "Token Swap",
            tokenIcons: activity.fungibleTokenTransfers.map(\.tokenIcon),
            actionIcon: nil,
            actionIconBackgroundColor: nil,
            title: "\(fromTransfer.tokenSymbol) → \(toTransfer.tokenSymbol)",
            generalDetails: [
                activity.dateDetails,
                activity.statusDetails,
                activity.networkFeeDetails
            ],
            swapDetails: [
                activity.provider
                    .map { Details(title: "Provider", value: $0, imageURL: activity.providerIcon) },
                fromTransfer.swapDetails,
                toTransfer.swapDetails
            ].compactMap { $0 }
        )
    }

    static func transferItem(with activity: Activity) -> Self? {
        guard let transfer = activity.fungibleTokenTransfers.first else { return nil }
        let isReceiving = transfer.amount > 0
        return .init(
            navigationTitle: isReceiving ? "Received" : "Sent",
            tokenIcons: [transfer.tokenIcon],
            actionIcon: isReceiving ? "arrow.down" : "paperplane.fill",
            actionIconBackgroundColor: isReceiving ? .lavenderBlue : .rockmanBlue,
            title: "\(isReceiving ? "+" : "-")\(abs(transfer.amount).formatted()) \(transfer.tokenSymbol)",
            titleColor: isReceiving ? .green : nil,
            generalDetails: [
                activity.dateDetails,
                activity.statusDetails,
                isReceiving ? activity.fromDetails : activity.toDetails,
                activity.networkFeeDetails
            ]
        )
    }

    static func genericItem(with activity: Activity) -> Self {
        .init(
            navigationTitle: "App Interaction",
            statusIcon: activity.isSuccess ? "checkmark" : "xmark",
            statusIconColor: activity.isSuccess ? .green : .red,
            description: activity.provider,
            generalDetails: [
                activity.dateDetails,
                activity.statusDetails,
                activity.networkFeeDetails
            ]
        )
    }
}

extension ActivityDetailsViewItem {
    struct Details: Identifiable {
        let id = UUID()
        let title: String
        let value: String
        let valueColor: Color?
        let imageURL: String?

        init(title: String, value: String, valueColor: Color? = nil, imageURL: String? = nil) {
            self.title = title
            self.value = value
            self.valueColor = valueColor
            self.imageURL = imageURL
        }
    }
}

private extension Activity {
    var dateDetails: ActivityDetailsViewItem.Details {
        let date = timestamp.formatted(date: .abbreviated, time: .omitted)
        let time = timestamp.formatted(date: .omitted, time: .shortened)
        return .init(title: "Date", value: "\(date) at \(time)")
    }

    var statusDetails: ActivityDetailsViewItem.Details {
        .init(
            title: "Status",
            value: isSuccess ? "Completed" : "Failed",
            valueColor: isSuccess ? .green : .red
        )
    }

    var networkFeeDetails: ActivityDetailsViewItem.Details {
        .init(title: "Network Fee", value: "\(fee.formatted()) SOL")
    }

    var fromDetails: ActivityDetailsViewItem.Details {
        .init(title: "From", value: senderAddress.truncatedAddress)
    }

    var toDetails: ActivityDetailsViewItem.Details {
        .init(title: "To", value: receiverAddress.truncatedAddress)
    }
}

private extension Activity.FungibleTokenTransfer {
    var swapDetails: ActivityDetailsViewItem.Details {
        .init(
            title: amount > 0 ? "You Received" : "You Paid",
            value: "\(amount > 0 ? "+" : "")\(amount.formatted()) \(tokenSymbol)",
            valueColor: amount > 0 ? .green : nil
        )
    }
}

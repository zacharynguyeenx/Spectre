import SwiftUI
import Combine

final class ActivityViewModel: ObservableObject {
    // MARK: - Private properties

    private let activityService: ActivityServiceProtocol
    @Published private var activities: [Activity] = []
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(activityService: ActivityServiceProtocol = ActivityService()) {
        self.activityService = activityService
    }

    // MARK: - Public

    var activitySections: [ActivitySection] {
        let groupedActivities = activities.reduce([Date: [Activity]]()) { current, activity in
            let date = Calendar.current.startOfDay(for: activity.timestamp)
            var current = current
            current[date] = (current[date] ?? []) + [activity]
            return current
        }
        return groupedActivities.keys.sorted(by: >).map { date in
            ActivitySection(
                date: date.formatted(date: .abbreviated, time: .omitted),
                items: groupedActivities[date]?
                    .sorted { $0.timestamp > $1.timestamp }
                    .map(item(for:)) ?? []
            )
        }
    }

    func getActivities() {
        activityService.getAllActivities()
            .sink { [weak self] in self?.activities = $0 }
            .store(in: &cancellables)
    }
}

private extension ActivityViewModel {
    func item(for activity: Activity) -> any ActivityItem {
        let genericItem = GenericActivityItem(
            isSuccess: activity.isSuccess,
            actionName: "App Interaction",
            appName: activity.appName,
            value: activity.isSuccess ? "\(activity.fee.formatted()) SOL" : "Failed"
        )

        switch activity.transactionType {
        case .transferFungible:
            guard let transfer = activity.fungibleTokenTransfers.first else { return genericItem }
            let isReceiving = transfer.amount > 0
            let address = isReceiving ? activity.senderAddress : activity.receiverAddress
            let truncatedAddress = [address.prefix(4), address.suffix(4)].joined(separator: "...")
            return TokenTransferActivityItem(
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
                fromTokenIcon: fromTransfer.tokenIcon,
                toTokenIcon: toTransfer.tokenIcon,
                actionName: ["Swap", activity.appName].compactMap { $0 }.joined(separator: " on "),
                description: "\(fromTransfer.tokenSymbol) → \(toTransfer.tokenSymbol)",
                toAmount: "+\(abs(toTransfer.amount).formatted()) \(toTransfer.tokenSymbol)",
                fromAmount: "-\(abs(fromTransfer.amount).formatted()) \(fromTransfer.tokenSymbol)"
            )

        case .none:
            return genericItem
        }
    }
}

struct ActivitySection: Identifiable {
    var id: String { date }
    let date: String
    let items: [any ActivityItem]
}

protocol ActivityItem: Identifiable {
    var id: UUID { get }
    var actionName: String { get }
}

struct SwapActivityItem: ActivityItem {
    let id = UUID()
    let fromTokenIcon: String
    let toTokenIcon: String
    let actionName: String
    let description: String
    let toAmount: String
    let fromAmount: String
}

struct TokenTransferActivityItem: ActivityItem {
    let id = UUID()
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
    let isSuccess: Bool
    let actionName: String
    let appName: String?
    let value: String
}

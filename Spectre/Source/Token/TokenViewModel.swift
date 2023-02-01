import SwiftUI
import Combine

final class TokenViewModel: ObservableObject {
    // MARK: - Private properties

    private let token: WalletDetails.Token
    private let activityService: ActivityServiceProtocol
    private let activityItemProvider: ActivityItemProviderProtocol

    @Published private var activities: [Activity] = []

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(
        token: WalletDetails.Token,
        activityService: ActivityServiceProtocol = ActivityService(),
        activityItemProvider: ActivityItemProviderProtocol = ActivityItemProvider()
    ) {
        self.token = token
        self.activityService = activityService
        self.activityItemProvider = activityItemProvider
    }

    // MARK: - Public

    var title: String { token.name }

    var cryptoAmount: String {
        "\(token.cryptoAmount.formatted()) \(token.symbol)"
    }

    var fiatAmount: String {
        token.fiatAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }

    var activityItems: [any ActivityItem] {
        activities.map(activityItemProvider.item(for:))
    }

    func getActivities() {
        activityService.getActivitiesForToken(with: token.address)
            .sink { [weak self] in self?.activities = $0 }
            .store(in: &cancellables)
    }
}

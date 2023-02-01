import SwiftUI
import Combine

final class ActivitiesViewModel: ObservableObject {
    // MARK: - Private properties

    private let activityService: ActivityServiceProtocol
    private let activityItemProvider: ActivityItemProviderProtocol

    @Published private var activities: [Activity] = []

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(
        activityService: ActivityServiceProtocol = ActivityService(),
        activityItemProvider: ActivityItemProviderProtocol = ActivityItemProvider()
    ) {
        self.activityService = activityService
        self.activityItemProvider = activityItemProvider
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
                    .map(activityItemProvider.item(for:)) ?? []
            )
        }
    }

    func getActivities() {
        activityService.getAllActivities()
            .sink { [weak self] in self?.activities = $0 }
            .store(in: &cancellables)
    }
}

struct ActivitySection: Identifiable {
    var id: String { date }
    let date: String
    let items: [any ActivityItem]
}

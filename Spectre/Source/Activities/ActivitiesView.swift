import SwiftUI

struct ActivitiesView: View {
    @State private var viewDidLoad = false
    @StateObject private var viewModel = ActivitiesViewModel()
    @State private var presentedActivity: Activity?

    var body: some View {
        NavigationStack {
            List {
                if viewModel.activitySections.isEmpty {
                    Spacer()
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                ForEach(viewModel.activitySections) { section in
                    Section(section.date) {
                        ForEach(section.items, id: \.id) { item in
                            Button {
                                presentedActivity = item.activity
                            } label: {
                                ActivityItemView(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                }
            }
            .sheet(item: $presentedActivity) {
                ActivityDetailsView(activity: $0)
            }
            .listStyle(.plain)
            .navigationTitle("Recent Activity")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
            .toolbarBackground(Color.navBar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear {
            if !viewDidLoad {
                viewModel.getActivities()
                viewDidLoad = true
            }
        }
        .preferredColorScheme(.dark)
        .tabItem {
            Label("Activities", systemImage: "bolt.fill")
                .labelStyle(IconOnlyLabelStyle())
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}

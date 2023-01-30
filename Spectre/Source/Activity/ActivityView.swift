import SwiftUI

struct ActivityView: View {
    @State private var viewDidLoad = false
    @StateObject private var viewModel = ActivityViewModel()

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
                            } label: {
                                Group {
                                    if let item = item as? GenericActivityItem {
                                        genericActivityView(for: item)
                                    } else if let item = item as? TokenTransferActivityItem {
                                        tokenTransferView(for: item)
                                    } else if let item = item as? SwapActivityItem {
                                        swapActivityView(for: item)
                                    }
                                }
                                .padding(12)
                                .background(.white.opacity(0.05))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                }
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

    func genericActivityView(for item: GenericActivityItem) -> some View {
        HStack {
            Image(systemName: item.isSuccess ? "checkmark" : "xmark")
                .resizable()
                .scaledToFit()
                .padding(15)
                .foregroundColor(item.isSuccess ? .green : .red)
                .frame(width: 45, height: 45)
                .background((item.isSuccess ? Color.green : Color.red).opacity(0.25))
                .clipShape(Circle())

            VStack(alignment: .leading) {
                HStack {
                    Text(item.actionName)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(item.value)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                item.appName.map {
                    Text($0)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
        }
    }

    func tokenTransferView(for item: TokenTransferActivityItem) -> some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: .init(string: item.tokenIcon)) { image in
                    image.resizable().scaledToFit()
                        .frame(width: 45, height: 45)
                } placeholder: {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .padding()
                        .frame(width: 45, height: 45)
                        .background(.gray)
                }
                .clipShape(Circle())
                Image(systemName: item.actionIcon)
                    .resizable()
                    .scaledToFit()
                    .padding(4)
                    .frame(width: 20, height: 20)
                    .background(item.actionIconColor)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.actionName)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(item.amount)
                        .fontWeight(.semibold)
                        .foregroundColor(item.amountColor)
                }
                Text(item.address)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
    }

    func swapActivityView(for item: SwapActivityItem) -> some View {
        HStack {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: .init(string: item.fromTokenIcon)) { image in
                    image.resizable().scaledToFit()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .padding()
                        .frame(width: 30, height: 30)
                        .background(.gray)
                }
                .clipShape(Circle())

                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        AsyncImage(url: .init(string: item.toTokenIcon)) { image in
                            image.resizable().scaledToFit()
                                .frame(width: 30, height: 30)
                        } placeholder: {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .opacity(0.5)
                                .padding()
                                .frame(width: 30, height: 30)
                                .background(.gray)
                        }
                        .clipShape(Circle())
                    }
                }
            }
            .frame(width: 45, height: 45)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.actionName)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(item.toAmount)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
                HStack(alignment: .top) {
                    Text(item.description)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(item.fromAmount)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}

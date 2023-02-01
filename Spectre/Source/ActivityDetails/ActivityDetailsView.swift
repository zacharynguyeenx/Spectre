import SwiftUI

struct ActivityDetailsView: View {
    // MARK: - Public

    let activity: Activity

    // MARK: - Private properties

    @Environment(\.dismiss) private var dismiss
    private var item: ActivityDetailsViewItem { .init(activity: activity) }

    // MARK: - Conformance

    // MARK: View

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        HStack {
                            Spacer()
                            VStack {
                                ZStack(alignment: .bottomTrailing) {
                                    HStack(spacing: -30) {
                                        ForEach(item.tokenIcons, id: \.self) { icon in
                                            TokenImage(urlString: icon, width: 80, height: 80)
                                        }
                                        if let statusIcon = item.statusIcon, let statusIconColor = item.statusIconColor {
                                            Image(systemName: statusIcon)
                                                .resizable()
                                                .scaledToFit()
                                                .padding(25)
                                                .frame(width: 80, height: 80)
                                                .foregroundColor(statusIconColor)
                                                .background(statusIconColor.opacity(0.15))
                                                .clipShape(Circle())
                                        }
                                    }
                                    if let actionIcon = item.actionIcon,
                                       let actionIconBackgroundColor = item.actionIconBackgroundColor {
                                        Image(systemName: actionIcon)
                                            .resizable()
                                            .scaledToFit()
                                            .padding(8)
                                            .frame(width: 30, height: 30)
                                            .background(actionIconBackgroundColor)
                                            .clipShape(Circle())
                                    }
                                }
                                item.title.map {
                                    Text($0)
                                        .font(.system(size: 38, weight: .bold))
                                        .foregroundColor(item.titleColor)
                                }
                                item.description.map {
                                    Text($0).fontWeight(.medium).padding(.top, 8).foregroundColor(.gray)
                                }
                            }
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }

                    Section {
                        ForEach(item.generalDetails, content: detailsView(with:))
                    }

                    if !item.swapDetails.isEmpty {
                        Section {
                            ForEach(item.swapDetails, content: detailsView(with:))
                        } header: {
                            Text("Swap Details")
                                .textCase(nil)
                                .font(.system(size: 17, weight: .medium))
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.bottom)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)

                Button {} label: {
                    Text("View on Solscan")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.bluePurple)
                        .clipShape(Capsule())
                }
                .padding()
            }
            .navigationTitle(item.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .standardUI
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Private functions

private extension ActivityDetailsView {
    func detailsView(with details: ActivityDetailsViewItem.Details) -> some View {
        HStack {
            Text(details.title).foregroundColor(.gray).fontWeight(.medium)
            Spacer()
            details.imageURL.map {
                TokenImage(urlString: $0, width: 30, height: 30)
            }
            Text(details.value).fontWeight(.semibold).foregroundColor(details.valueColor)
        }
        .padding([.top, .bottom], 18)
        .padding([.leading, .trailing])
        .listRowBackground(Color.darkOnyxGray)
        .listRowSeparatorTint(Color.background)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
    }
}

// MARK: - Previews

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let genericSuccessActivity = Activity(
            transactionType: nil,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [],
            isSuccess: true,
            fee: 0.000005,
            timestamp: Date()
        )
        ActivityDetailsView(activity: genericSuccessActivity)

        let genericFailureActivity = Activity(
            transactionType: nil,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [],
            isSuccess: false,
            fee: 0.000005,
            provider: "Jupiter",
            timestamp: Date()
        )
        ActivityDetailsView(activity: genericFailureActivity)

        let swapActivity = Activity(
            transactionType: .swap,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [
                .init(tokenAddress: "", tokenSymbol: "GST", tokenIcon: Stubs.gstIcon, amount: -158.04999),
                .init(tokenAddress: "", tokenSymbol: "USDC", tokenIcon: Stubs.usdcIcon, amount: 3.68146)
            ],
            isSuccess: true,
            fee: 0.000005,
            provider: "Jupiter",
            providerIcon: Stubs.jupiterIcon,
            timestamp: Date()
        )
        ActivityDetailsView(activity: swapActivity)

        let sentActivity = Activity(
            transactionType: .transferFungible,
            senderAddress: "",
            receiverAddress: "CNxzTnQaPHokwJ4a53wPvmYdaYz1QR4ZiWHutfSoneZX",
            fungibleTokenTransfers: [
                .init(tokenAddress: "", tokenSymbol: "USDC", tokenIcon: Stubs.usdcIcon, amount: -29.52355)
            ],
            isSuccess: true,
            fee: 0.000005,
            timestamp: Date()
        )
        ActivityDetailsView(activity: sentActivity)

        let receivedActivity = Activity(
            transactionType: .transferFungible,
            senderAddress: "CNxzTnQaPHokwJ4a53wPvmYdaYz1QR4ZiWHutfSoneZX",
            receiverAddress: "",
            fungibleTokenTransfers: [
                .init(tokenAddress: "", tokenSymbol: "GST", tokenIcon: Stubs.gstIcon, amount: 158.05)
            ],
            isSuccess: true,
            fee: 0.000005,
            timestamp: Date()
        )
        ActivityDetailsView(activity: receivedActivity)
    }
}

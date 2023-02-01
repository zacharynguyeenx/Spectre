import SwiftUI

struct ActivityItemView: View {
    let item: any ActivityItem

    var body: some View {
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

    func genericActivityView(for item: GenericActivityItem) -> some View {
        HStack {
            Image(systemName: item.isSuccess ? "checkmark" : "xmark")
                .resizable()
                .scaledToFit()
                .padding(15)
                .foregroundColor(item.isSuccess ? .green : .red)
                .frame(width: 45, height: 45)
                .background((item.isSuccess ? Color.green : Color.red).opacity(0.15))
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
                item.provider.map {
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
                TokenImage(urlString: item.tokenIcon, width: 45, height: 45)
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
                TokenImage(urlString: item.fromTokenIcon, width: 30, height: 30)

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

struct ActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(
            transactionType: nil,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [],
            isSuccess: true,
            fee: 0,
            timestamp: Date()
        )
        List {
            Group {
                ActivityItemView(
                    item: GenericActivityItem(
                        activity: activity,
                        isSuccess: true,
                        actionName: "App Interaction",
                        provider: nil,
                        value: "-0.000005 SOL"
                    )
                )
                ActivityItemView(
                    item: TokenTransferActivityItem(
                        activity: activity,
                        tokenIcon: Stubs.gstIcon,
                        actionIcon: "paperplane.fill",
                        actionIconColor: Color.rockmanBlue,
                        actionName: "Sent",
                        address: "To: CiK9...eXbG",
                        amount: "-29.52355 USDC",
                        amountColor: .white
                    )
                )
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
        }
        .listStyle(.plain)
        .preferredColorScheme(.dark)
    }
}

import SwiftUI

struct TokenView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: TokenViewModel
    @State private var viewDidLoad = false
    @State private var presentedActivity: Activity?

    init(token: WalletDetails.Token) {
        _viewModel = StateObject(wrappedValue: TokenViewModel(token: token))
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                VStack {
                    Text(viewModel.cryptoAmount)
                        .font(.system(size: 50, weight: .semibold))
                    Text(viewModel.fiatAmount)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)

                HStack(spacing: 12.0) {
                    Button {} label: {
                        Text("Deposit")
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.bluePurple)
                            .clipShape(Capsule())
                    }
                    Button {} label: {
                        Text("Send")
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(Color.bluePurple)
                            .clipShape(Capsule())
                    }
                }
                .font(.system(size: 17, weight: .semibold))
                .tint(.white)
                .buttonStyle(.plain)
                .padding(.top)

                VStack {
                    HStack {
                        Text("Recent Activity")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                    }

                    ForEach(viewModel.activityItems, id: \.id) { item in
                        Button {
                            presentedActivity = item.activity
                        } label: {
                            ActivityItemView(item: item)
                        }
                        .tint(.white)
                    }
                }
                .padding(.top, 40)
            }
            .padding()
        }
        .onAppear {
            if !viewDidLoad {
                viewModel.getActivities()
                viewDidLoad = true
            }
        }
        .sheet(item: $presentedActivity) {
            ActivityDetailsView(activity: $0)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left").foregroundColor(.white)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    Text("Hello")
                } label: {
                    Image(systemName: "ellipsis").foregroundColor(.white)
                }
            }
        }
        .standardUI
    }
}

struct TokenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TokenView(
                token: .init(
                    name: "USD Coin",
                    icon: "",
                    symbol: "USDC",
                    address: Stubs.usdcAddress,
                    cryptoAmount: 5.48195,
                    fiatAmount: 5.49,
                    fiatAmountChange: 0
                )
            )
        }
        .preferredColorScheme(.dark)
    }
}

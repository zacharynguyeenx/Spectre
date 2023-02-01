import SwiftUI

struct WalletView: View {
    @StateObject private var viewModel = WalletViewModel()
    @State private var settingsIsPresented = false
    @State private var viewDidLoad = false
    @State private var tokenIsPresented = false
    @State private var presentedToken: WalletDetails.Token?

    var body: some View {
        NavigationStack {
            ZStack {
                background
                ScrollView {
                    LazyVStack {
                        totalBalance
                        actions
                        ForEach(viewModel.tokenItems, content: tokenView(with:))
                        manageTokenList
                    }
                    .padding()
                }
            }
            .toolbar {
                settings
                title
                scan
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if !viewDidLoad {
                viewModel.bind()
                viewDidLoad = true
            }
        }
        .preferredColorScheme(.dark)
        .tabItem {
            Label("Wallet", systemImage: "dollarsign.circle.fill").labelStyle(IconOnlyLabelStyle())
        }
        .sheet(isPresented: $settingsIsPresented) { SettingsView() }
    }

    var settings: ToolbarItem<(), some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                settingsIsPresented = true
            } label: {
                Text(viewModel.walletInitial)
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .bold))
                    .frame(width: 24, height: 24)
                    .background(Color.bluePurple)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white, lineWidth: 1))
            }
        }
    }

    var title: ToolbarItem<(), some View> {
        ToolbarItem(placement: .principal) {
            Button {

            } label: {
                Text(viewModel.walletName)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                Text(viewModel.walletAddress)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
    }

    var scan: ToolbarItem<(), some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
            } label: {
                Image(systemName: "qrcode.viewfinder")
            }
            .foregroundColor(.white)
        }
    }

    var background: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: viewModel.totalBalanceChangeColor.opacity(0.25), location: 0.0),
                    .init(color: .black, location: 0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            Color.gray.opacity(0.15)
        }
        .ignoresSafeArea()
    }

    var totalBalance: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(viewModel.totalBalance)
                    .font(.system(size: 60, weight: .semibold))
                Spacer()
            }
            HStack {
                Spacer()
                Text(viewModel.totalBalanceChange)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(viewModel.totalBalanceChangeColor)
                viewModel.totalBalanceChangePercentage.map {
                    Text($0)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(viewModel.totalBalanceChangeColor)
                        .padding(2)
                        .background(viewModel.totalBalanceChangeColor.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Spacer()
            }
        }
        .padding()
    }

    var actions: some View {
        HStack(spacing: 12.0) {
            Button {} label: {
                Text("Deposit")
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color.bluePurple)
                    .clipShape(Capsule())
            }
            Button {} label: {
                Text("Buy")
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
        .padding([.top, .bottom])
    }

    func tokenView(with item: TokenItem) -> some View {
        NavigationLink {
            TokenView(token: item.token)
        } label: {
            HStack {
                AsyncImage(url: .init(string: item.icon)) { image in
                    image.resizable().scaledToFit()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(.gray)
                }
                .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.system(size: 17, weight: .semibold))
                    Text(item.cryptoAmount)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white.opacity(0.75))
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.fiatAmount)
                        .font(.system(size: 17, weight: .semibold))
                    Text(item.fiatAmountChange)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(item.fiatAmountChangeColor)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }

    var manageTokenList: some View {
        HStack {
            Spacer()
            Button {

            } label: {
                Label("Manage token list", systemImage: "slider.horizontal.3")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
            }
            Spacer()
        }
        .padding(.top)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}

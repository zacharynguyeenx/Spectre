import SwiftUI

struct WalletView: View {
    @StateObject private var viewModel = WalletViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                background
                List {
                    Section { totalBalance }
                    Section { actions }
                    Section { ForEach(viewModel.tokenItems, content: tokenView(with:)) }
                    Section { manageTokenList }
                }
                .listStyle(.plain)
            }
            .toolbar {
                profile
                title
                scan
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear { viewModel.getWalletDetails() }
        .preferredColorScheme(.dark)
        .tabItem {
            Label("Wallet", systemImage: "dollarsign.circle.fill").labelStyle(IconOnlyLabelStyle())
        }
    }

    var profile: ToolbarItem<(), some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {

            } label: {
                Text("W")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .bold))
                    .frame(width: 24, height: 24)
                    .background(.indigo)
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
                Text(viewModel.totalBalanceChangePercentage)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(viewModel.totalBalanceChangeColor)
                    .padding(2)
                    .background(viewModel.totalBalanceChangeColor.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
            }
        }
        .padding()
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }

    var actions: some View {
        HStack(spacing: 12.0) {
            Button("Deposit") {}
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.indigo)
                .clipShape(Capsule())
            Button("Buy") {}
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.indigo)
                .clipShape(Capsule())
            Button("Send") {}
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.indigo)
                .clipShape(Capsule())
        }
        .padding(.bottom)
        .font(.system(size: 17, weight: .semibold))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }

    func tokenView(with item: TokenItem) -> some View {
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
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
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
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}

import SwiftUI

struct AccountsView: View {
    let accountSelected: () -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AccountsViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.accountItems) { item in
                    Button {
                        viewModel.selectAccount(with: item)
                        accountSelected()
                    } label: {
                        HStack(spacing: 12) {
                            ZStack {
                                if item.isHighlighted {
                                    Circle()
                                        .strokeBorder(lineWidth: 2)
                                        .frame(width: 45, height: 45)
                                } else {
                                    Circle()
                                        .foregroundColor(Color.bluePurple)
                                        .frame(width: 45, height: 45)
                                }
                                Text(item.initial).bold()
                            }
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.system(size: 16, weight: .semibold))
                                Text(item.truncatedAddress)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "ellipsis").padding([.trailing], 8)
                        }
                    }
                    .padding(12)
                    .background(item.isHighlighted ? Color.bluePurple : Color.darkOnyxGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 16, leading: 16, bottom: 0, trailing: 16))
                }
            }

            Spacer()

            NavigationLink {
                Text("Hello")
            } label: {
                HStack {
                    Spacer()
                    Text("Add / Connect Wallet")
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.blackTieGray)
                .clipShape(Capsule())
                .padding()
            }
        }
        .listStyle(.plain)
        .background(Color.background)
        .navigationTitle("Your Accounts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.navBar, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
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
                    Image(systemName: "plus").foregroundColor(.white)
                }
            }
        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AccountsView(accountSelected: {})
        }
        .preferredColorScheme(.dark)
    }
}

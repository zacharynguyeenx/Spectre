import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            List {
                ZStack {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .strokeBorder(lineWidth: 2)
                                .frame(width: 45, height: 45)
                            Text(viewModel.accountItem.initial).bold()
                        }
                        VStack(alignment: .leading) {
                            Text(viewModel.accountItem.name)
                                .font(.system(size: 16, weight: .semibold))
                            Text(viewModel.accountItem.truncatedAddress)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right").padding([.trailing], 8)
                    }
                    NavigationLink {
                        AccountsView(accountSelected: {
                            dismiss()
                        })
                    } label: {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .padding(12)
                .background(Color.bluePurple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 16, leading: 16, bottom: 0, trailing: 16))

                ForEach(viewModel.menus) { menu in
                    ZStack {
                        HStack(spacing: 12) {
                            Text(menu.title).font(.system(size: 16, weight: .semibold))
                            Spacer()
                            if let value = menu.value {
                                Text(value)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                            Image(systemName: "chevron.right").padding([.trailing], 8)
                        }
                        NavigationLink {
                            Text("Hello")
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .padding(12)
                    .padding([.top, .bottom], 6)
                    .background(Color.darkOnyxGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 16, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .listStyle(.plain)
            .background(Color.background)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.navBar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark").foregroundColor(.white)
                    }
                }
            }
            .onAppear { viewModel.bind() }
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

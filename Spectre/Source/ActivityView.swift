import SwiftUI

struct ActivityView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Nov 12, 2022") {
                    HStack {
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: .init(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png")) { image in
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
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(4)
                                .frame(width: 20, height: 20)
                                .background(.blue)
                                .clipShape(Circle())
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Sent")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("-29.52355 USDC")
                                    .fontWeight(.semibold)
                            }
                            Text("To: CiK9…eXbG")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(12)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))

                    HStack {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .padding(15)
                            .foregroundColor(.green)
                            .frame(width: 45, height: 45)
                            .background(.green.opacity(0.25))
                            .clipShape(Circle())

                        HStack {
                            Text("App Interaction")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("-0.000005 SOL")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(12)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                }
                Section("Nov 10, 2022") {
                    HStack {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .padding(15)
                            .foregroundColor(.red)
                            .frame(width: 45, height: 45)
                            .background(.red.opacity(0.25))
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            HStack {
                                Text("App Interaction")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("Failed")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                            Text("Jupiter")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(12)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))

                    HStack {
                        ZStack(alignment: .topLeading) {
                            AsyncImage(url: .init(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png")) { image in
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
                                    AsyncImage(url: .init(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png")) { image in
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
                                Text("Token Swap")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("+1.80049 USDC")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.green)
                            }
                            HStack(alignment: .top) {
                                Text("SOL → USDC")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("-0.11883 SOL")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding(12)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                }
            }
            .listStyle(.plain)
            .navigationTitle("Recent Activity")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
            .toolbarBackground(Color.navBar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
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
        ActivityView()
    }
}

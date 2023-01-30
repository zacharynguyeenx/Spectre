import SwiftUI

struct SwapView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 0) {
                        VStack {
                            HStack {
                                Text("You Pay")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Max")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                Text("0.083672161 SOL")
                                    .font(.system(size: 15, weight: .bold))
                            }
                            HStack {
                                Text("0.083672161")
                                    .font(.system(size: 32, weight: .medium))
                                Spacer()
                                HStack {
                                    AsyncImage(url: .init(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png")) { image in
                                        image.resizable().scaledToFit()
                                            .frame(width: 32)
                                    } placeholder: {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(0.5)
                                            .padding()
                                            .frame(width: 32, height: 32)
                                            .background(.gray)
                                    }
                                    .clipShape(Circle())
                                    Text("SOL")
                                        .font(.system(size: 17, weight: .semibold))
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10)
                                        .padding(.trailing, 8)
                                }
                                .padding(8)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Capsule())
                            }
                            .padding(.top)
                        }
                        .padding()
                        .padding([.top, .bottom])
                        .background(Color(hue: 0, saturation: 0, brightness: 0.12))
                        ZStack {
                            VStack(spacing: 0) {
                                Color(hue: 0, saturation: 0, brightness: 0.12).frame(maxHeight: .infinity)
                                Color.white.opacity(0.2).frame(height: 1)
                                Color.clear.frame(maxHeight: .infinity)
                            }
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .scaledToFit()
                                .padding(12)
                                .frame(width: 45, height: 45)
                                .background(Color(hue: 0, saturation: 0, brightness: 0.2))
                                .clipShape(Circle())
                        }
                        VStack {
                            HStack {
                                Text("You Receive")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            HStack {
                                Text("2.01869")
                                    .font(.system(size: 32, weight: .medium))
                                Spacer()
                                HStack {
                                    AsyncImage(url: .init(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png")) { image in
                                        image.resizable().scaledToFit()
                                            .frame(width: 32)
                                    } placeholder: {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(0.5)
                                            .padding()
                                            .frame(width: 32, height: 32)
                                            .background(.gray)
                                    }
                                    .clipShape(Circle())
                                    Text("USDC")
                                        .font(.system(size: 17, weight: .semibold))
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10)
                                        .padding(.trailing, 8)
                                }
                                .padding(8)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Capsule())
                            }
                            .padding(.top)
                        }
                        .padding()
                        VStack(spacing: 12) {
                            HStack {
                                Text("Best price")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5))
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                                    .opacity(0.75)
                                Spacer()
                                Text("1 SOL ≈ 24.12614 USDC")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                            HStack {
                                Text("Provider")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5))
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                                    .opacity(0.75)
                                Spacer()
                                Text("Cropper (85%) + Aldrin (15%)")
                                    .font(.system(size: 16, weight: .semibold))
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 6)
                            }
                            HStack {
                                Text("Price Impact")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5))
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                                    .opacity(0.75)
                                Spacer()
                                Text("<0.01%")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                            HStack {
                                Text("Estimated Fees")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.5))
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                                    .opacity(0.75)
                                Spacer()
                                Text("$0.00012")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .padding()
                        .background(Color(hue: 0, saturation: 0, brightness: 0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    }
                }
                Spacer()
                Button("Review Order") {}
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.bluePurple)
                    .clipShape(Capsule())
                    .padding()
                    .padding(.bottom)
            }
            .navigationTitle("Swap Tokens")
            .navigationBarTitleDisplayMode(.inline)
            .background(.gray.opacity(0.15))
            .toolbarBackground(Color.navBar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
        .tabItem {
            Label("Swap", systemImage: "arrow.left.arrow.right")
                .labelStyle(IconOnlyLabelStyle())
        }
    }
}

struct SwapView_Previews: PreviewProvider {
    static var previews: some View {
        SwapView()
    }
}

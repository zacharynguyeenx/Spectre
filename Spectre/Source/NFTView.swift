import SwiftUI

struct NFT: Identifiable {
    let id = UUID()
    let imageURL: String
    let name: String
    let count: Int

    static let nfts: [NFT] = [
        .init(
            imageURL: "https://i.seadn.io/gae/yIm-M5-BpSDdTEIJRt5D6xphizhIdozXjqSITgK4phWq7MmAU3qE7Nw7POGCiPGyhtJ3ZFP8iJ29TFl-RLcGBWX5qI4-ZcnCPcsY4zI?auto=format&w=1000",
            name: "Otherdeed for Otherside",
            count: 4
        ),
        .init(
            imageURL: "https://i.seadn.io/gae/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE?auto=format&w=1000",
            name: "CryptoPunks",
            count: 2
        ),
        .init(
            imageURL: "https://i.seadn.io/gcs/files/a8a2c681f0241bc7128b9ee204a501f2.jpg?auto=format&w=1000",
            name: "Sewer Pass",
            count: 5
        ),
        .init(
            imageURL: "https://i.seadn.io/gcs/files/ee67a8d1f6a2ba1ffbdb64a48c708f51.png?auto=format&w=1000",
            name: "Shilly: The Access Passes",
            count: 1
        ),
        .init(
            imageURL: "https://i.seadn.io/gae/lHexKRMpw-aoSyB1WdFBff5yfANLReFxHzt1DOj_sg7mS14yARpuvYcUtsyyx-Nkpk6WTcUPFoG53VnLJezYi8hAs0OxNZwlw6Y-dmI?auto=format&w=1000",
            name: "Mutant Ape Yacht Club",
            count: 3
        )
    ]
}

struct NFTView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 140))]) {
                    ForEach(NFT.nfts) { nft in
                        Button {
                        } label: {
                            ZStack {
                                AsyncImage(url: .init(string: nft.imageURL)) { image in
                                    image.resizable().aspectRatio(1, contentMode: .fill)
                                } placeholder: {
                                    ZStack {
                                        Color(hue: 0, saturation: 0, brightness: 0.15)
                                        Image(systemName: "photo.fill").resizable().scaledToFit()
                                            .frame(width: 40)
                                            .opacity(0.5)
                                    }
                                    .aspectRatio(1, contentMode: .fill)
                                }
                                VStack() {
                                    Spacer()
                                    HStack {
                                        HStack {
                                            Text(nft.name)
                                                .lineLimit(1)
                                                .font(.system(size: 14, weight: .bold))
                                            Text("\(nft.count)")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.gray)
                                        }
                                        .padding(8)
                                        .background(Color(hue: 0, saturation: 0, brightness: 0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(8)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .tint(.white)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(4)
                }
                .padding()
            }
            .navigationTitle("Your Collectibles")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
            .toolbarBackground(Color.navBar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
        .tabItem {
            Label("NFT", systemImage: "square.grid.2x2.fill")
                .labelStyle(IconOnlyLabelStyle())
        }
    }
}

struct NFTView_Previews: PreviewProvider {
    static var previews: some View {
        NFTView()
    }
}

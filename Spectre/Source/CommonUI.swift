import SwiftUI

extension View {
    var standardUI: some View {
        background(Color.background)
            .toolbarBackground(Color.navBar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .tint(.white)
    }
}

struct TokenImage: View {
    let urlString: String
    let width: CGFloat?
    let height: CGFloat?

    var body: some View {
        AsyncImage(url: .init(string: urlString)) { image in
            image.resizable().scaledToFit()
                .frame(width: width, height: height)
        } placeholder: {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .opacity(0.5)
                .padding()
                .frame(width: width, height: height)
                .background(.gray)
        }
        .clipShape(Circle())
    }
}

extension String {
    var truncatedAddress: String { [prefix(4), suffix(4)].joined(separator: "...") }
}

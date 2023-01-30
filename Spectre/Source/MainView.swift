import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            WalletView()
            NFTView()
            SwapView()
            ActivityView()
            BrowserView()
        }
        .tint(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

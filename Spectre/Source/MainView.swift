import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            WalletView()
            NFTView()
            SwapView()
            ActivitiesView()
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

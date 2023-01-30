import SwiftUI

struct BrowserView: View {
    @State private var searchText = ""
    @FocusState private var searchFieldIsFocused

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        if !searchFieldIsFocused {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        TextField("Search or enter website", text: $searchText)
                            .focused($searchFieldIsFocused)
                            .fontWeight(.medium)
                    }
                    .padding(8)
                    .foregroundColor(.gray)
                    .background(Color.darkElfGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    if searchFieldIsFocused {
                        Button("Cancel") {
                            searchFieldIsFocused = false
                        }
                    }
                }
                .padding()
                .background(Color.navBar)
                .animation(.easeOut(duration: 0.2), value: searchFieldIsFocused)

                List {
                    Section("Favorites") {
                        Text("Your favorites will be shown here")
                            .fontWeight(.medium)
                            .padding([.top, .bottom])
                            .foregroundColor(.gray)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    Section("Recents") {
                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                AsyncImage(url: .init(string: "https://pbs.twimg.com/profile_images/1609874776151183362/T1eJXDui_400x400.png")) {
                                    $0.resizable().scaledToFit().clipShape(Circle())
                                } placeholder: { }
                                    .frame(width: 32)
                                Text("jup.ag")
                                Spacer()
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.visible)

                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                AsyncImage(url: .init(string: "https://pbs.twimg.com/profile_images/1544105652330631168/ZuvjfGkT_400x400.png")) {
                                    $0.resizable().scaledToFit().clipShape(Circle())
                                } placeholder: { }
                                    .frame(width: 32)
                                Text("opensea.io")
                                Spacer()
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.visible)
                    }
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .background(Color.background)
        }
        .preferredColorScheme(.dark)
        .tabItem {
            Label("Browser", systemImage: "globe")
                .labelStyle(IconOnlyLabelStyle())
        }
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}

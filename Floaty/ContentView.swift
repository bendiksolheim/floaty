import SwiftUI

struct ContentView: View {
    let webViewStore = WebViewStore()
    @ObservedObject var uiState = UIState()
    
    var body: some View {
        ZStack(alignment: .top) {
            WebView(webView: webViewStore.webView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            AddressBar()
                .onHover { _ in self.uiState.addressBarVisible.toggle() }
                .opacity(uiState.addressBarVisible ? 1 : 0)
                .animation(.easeInOut)
                .environmentObject(uiState)
                .environmentObject(webViewStore)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class UIState: ObservableObject {
    @Published var url: String = ""
    @Published var addressBarVisible = false
}

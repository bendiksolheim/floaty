import SwiftUI

struct ContentView: View {
    let webViewStore = WebViewStore()
    let uiState = UIState()
    
    var body: some View {
        ZStack(alignment: .top) {
            WebView(webView: webViewStore.webView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(Color.blue, width: 2)
            AddressBar()
                .border(Color.red, width: 2)
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

struct AddressBar: View {
    @EnvironmentObject var webViewStore: WebViewStore
    @EnvironmentObject var uiState: UIState
    
    var body: some View {
        HStack {
            TextField("URL", text: $uiState.url)
            Button(action: goto) {
                Text("Go")
            }
        }
    }
    
    func goto() -> Void {
        if let parsedUrl = URL(string: uiState.url) {
            webViewStore.webView.load(URLRequest(url: parsedUrl))
        }
    }
}

class UIState: ObservableObject {
    @Published var url: String = ""
}

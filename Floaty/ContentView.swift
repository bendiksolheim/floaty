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

struct AddressBar: View {
    @EnvironmentObject var webViewStore: WebViewStore
    @EnvironmentObject var uiState: UIState
    
    var body: some View {
        Group {
            HStack {
                TextField("URL", text: $uiState.url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: goto) {
                    Text("Go")
                }
            }.padding(.all, 10)
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(hex: "2D2D2D"), Color(hex: "2D2D2D")]), startPoint: .top, endPoint: .bottom)
        )
    }
    
    func goto() -> Void {
        if let parsedUrl = URL(string: uiState.url) {
            webViewStore.webView.load(URLRequest(url: parsedUrl))
        }
    }
}

class UIState: ObservableObject {
    @Published var url: String = ""
    @Published var addressBarVisible = false
}

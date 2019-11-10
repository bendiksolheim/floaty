import SwiftUI

struct ContentView: View {
    var webViewStore: WebViewStore = WebViewStore()
    @State private var url: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("URL", text: $url)
                Button(action: goto) {
                    Text("Go")
                }
            }
            WebView(webView: webViewStore.webView)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }.onAppear {
            if let url = URL(string: "https://nrk.no") {
                print("LOL")
                self.webViewStore.webView.load(URLRequest(url: url))
            }
        }
    }
    
    func goto() -> Void {
        if let parsedUrl = URL(string: url) {
            webViewStore.webView.load(URLRequest(url: parsedUrl))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

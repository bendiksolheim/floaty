import SwiftUI

struct AddressBar: View {
    @EnvironmentObject var webViewStore: WebViewStore
    @EnvironmentObject var uiState: UIState
    
    var body: some View {
        Group {
            HStack {
                TextField("URL", text: $uiState.url, onCommit: goto)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: goto) {
                    Text("Go")
                }
            }.padding(.all, 15)
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(hex: "363636"), Color(hex: "2C2C2C")]), startPoint: .top, endPoint: .bottom)
        )
    }
    
    func goto() -> Void {
        let prefixedUrl = uiState.url.starts(with: "http")
            ? uiState.url
            : "https://\(uiState.url)"
        
        if let parsedUrl = URL(string: prefixedUrl) {
            webViewStore.webView.load(URLRequest(url: parsedUrl))
        }
    }
}

struct AddressBar_Previews: PreviewProvider {
    static var previews: some View {
        AddressBar()
    }
}

import SwiftUI

struct ContentView: View {
    let webViewStore = WebViewStore()
    @ObservedObject var uiState = UIState()
    
    let moveWindow: (_ location: CGSize) -> Void
    
    init(moveWindow: @escaping (_ location: CGSize) -> Void) {
        self.moveWindow = moveWindow
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            WebView(webView: webViewStore.webView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            AddressBar()
                .onHover { _ in
                    if self.uiState.addressBarVisible {
                        self.uiState.timer?.invalidate()
                        self.uiState.timer = nil
                        self.uiState.addressBarVisible.toggle()
                    } else {
                        if let timer = self.uiState.timer {
                            timer.invalidate()
                            self.uiState.timer = nil
                        } else {
                            self.uiState.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in self.uiState.addressBarVisible.toggle() })
                        }
                    }
                    
                }
                .opacity(uiState.addressBarVisible ? 1 : 0)
                .animation(.easeInOut)
                .environmentObject(uiState)
                .environmentObject(webViewStore)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in self.moveWindow(value.translation) }
                )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(moveWindow: {v in print("\(v)")})
    }
}

class UIState: ObservableObject {
    @Published var url: String = ""
    @Published var addressBarVisible = false
    @Published var timer: Timer?
}

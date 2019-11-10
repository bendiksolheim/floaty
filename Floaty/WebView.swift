import SwiftUI
import Combine
import WebKit
import Fullscreen

public class WebViewStore: ObservableObject {
    public let webView: WKWebView
    public let didChange = PassthroughSubject<Void, Never>()
    private var observers: [AnyCancellable] = []
    
    public init(webView: WKWebView = WKWebView()) {
        self.webView = webView
        self.webView.configuration.preferences._setFullScreenEnabled(true)

        func subscriber<Value>(for keyPath: KeyPath<WKWebView, Value>) -> AnyCancellable {
            return AnyCancellable(webView.publisher(for: keyPath).sink { a in self.didChange.send(); print("\(keyPath): \(a)") })
        }
        
        observers = [
            subscriber(for: \.title),
            subscriber(for: \.url),
            subscriber(for: \.isLoading),
            subscriber(for: \.estimatedProgress),
            subscriber(for: \.hasOnlySecureContent),
            subscriber(for: \.serverTrust),
            subscriber(for: \.canGoBack),
            subscriber(for: \.canGoForward)
        ]
    }
    
    deinit {
        observers.forEach {
            $0.cancel()
        }
    }
}

struct WebView: NSViewRepresentable {
    public let webView: WKWebView
    public typealias NSViewType = NSViewContainerView<WKWebView>
    
    public init(webView: WKWebView) {
        self.webView = webView
    }
    
    func makeNSView(context: NSViewRepresentableContext<WebView>) -> WebView.NSViewType {
        return NSViewContainerView()
    }
    
    func updateNSView(_ nsView: WebView.NSViewType, context: NSViewRepresentableContext<WebView>) {
        if nsView.contentView !== webView {
            nsView.contentView = webView
        }
    }
}

public class NSViewContainerView<ContentView: NSView> : NSView {
    var contentView: ContentView? {
        willSet {
            contentView?.removeFromSuperview()
        }
        didSet {
            if let contentView = contentView {
                addSubview(contentView)
                contentView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    contentView.topAnchor.constraint(equalTo: topAnchor),
                    contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            }
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(webView: WKWebView())
    }
}

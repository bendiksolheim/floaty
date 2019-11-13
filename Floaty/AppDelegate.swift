import Cocoa
import SwiftUI
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func moveWindow(location: CGSize) -> Void {
        let newLocation = NSOffsetRect(window.frame, location.width, location.height)
        window.setFrame(newLocation, display: true)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView(moveWindow: moveWindow)

        window = CustomWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.closable, .resizable, .hudWindow],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        window.level = .floating
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


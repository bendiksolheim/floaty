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
            styleMask: [.closable, .resizable],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        window.level = .floating
        
        if let menu = NSApp.mainMenu {
            modify(menu: menu)
        }
    }
    
    func modify(menu: NSMenu) {
        menu.removeItem(at: 4) // View
        menu.removeItem(at: 3) // Format
        
        if let file = menu.item(at: 1) {
            let fileMenu = file.submenu!
            fileMenu.removeItem(at: 1) // Open
            fileMenu.removeItem(at: 0) // New
            let openLocation = NSMenuItem(title: "Open location", action: #selector(AppDelegate.test(sender:)), keyEquivalent: "l")
            openLocation.keyEquivalentModifierMask = .command
            openLocation.isEnabled = true
            fileMenu.insertItem(openLocation, at: 0)
        }
    }
    
    @objc func test(sender: NSMenuItem) {
        print("lol")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

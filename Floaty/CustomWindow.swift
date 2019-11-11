import Foundation
import AppKit

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        get {
            return true
        }
    }
}

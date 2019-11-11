//
//  CustomWindow.swift
//  Floaty
//
//  Created by Bendik Solheim on 11/11/2019.
//  Copyright © 2019 Bendik Solheim. All rights reserved.
//

import Foundation
import AppKit

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        get {
            return true
        }
    }
}

//
//  AddressBar.swift
//  Floaty
//
//  Created by Bendik Solheim on 11/11/2019.
//  Copyright © 2019 Bendik Solheim. All rights reserved.
//

import SwiftUI

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
            }.padding(.all, 15)
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(hex: "363636"), Color(hex: "2C2C2C")]), startPoint: .top, endPoint: .bottom)
        )
    }
    
    func goto() -> Void {
        if let parsedUrl = URL(string: uiState.url) {
            webViewStore.webView.load(URLRequest(url: parsedUrl))
        }
    }
}

struct AddressBar_Previews: PreviewProvider {
    static var previews: some View {
        AddressBar()
    }
}

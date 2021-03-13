//
//  SwiftUIBoggleApp.swift
//  SwiftUIBoggle
//
//  Created by Chris Williamson on 12/02/2021.
//

import SwiftUI

@main
struct SwiftUIBoggleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GameController())
        }
    }
}

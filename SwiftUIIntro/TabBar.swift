//
//  TabBar.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/31/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

/*
 
 .edgaesIgnoringSafeArea is no longer needed after Xcode 11.4.1
 **/

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        
        //// Previewing devices
        /// Multiple devices does not wiork with live preview
        /// use Group for multiple devices.
        /// option click in `previewDevice` to see device syntaxes/
        Group {
            TabBar().previewDevice("iPhone 8")
        }
    }
}

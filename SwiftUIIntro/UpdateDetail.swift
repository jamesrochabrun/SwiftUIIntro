//
//  UpdateDetail.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/31/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

/*
 Scrollview can be replaced by a List!
 to debug views disable the preview and disable the pin
 https://designcode.io/swiftui-navigation-style-and-passing-data min -2:21
 */

struct UpdateDetail: View {
    
    var update: Update!
    
    var body: some View {
        
        List { /// can also be a
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                /// This will fix issues with multi line labels.
            }
            .navigationBarTitle(update.title)
        } // dependent on the navigation view wrapper in `updateList`
            .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}

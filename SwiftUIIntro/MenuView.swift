//
//  MenuView.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/22/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

/**
 
 - start from the content first not the container
 - for more info about fonts https://designcode.io/swiftui-sf-symbols-and-props minute 3:40
 */

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign out", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(radius: 30)
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {

    // MARK: Properties
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold))
                .imageScale(.large)
                .frame(width: 32, height: 32)
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
        }
    }
}

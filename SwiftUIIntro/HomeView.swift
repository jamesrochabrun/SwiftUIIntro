//
//  HomeView.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/22/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

/**
 
 - .constant something will help with the binding for previews
 
 - Swift ui always takes the minimum size algins everything to the largest content for example to the image.
 - when using scrollviews: the scrolliview direction does not define the layout , you need to deifne it using a H or V stack
 */

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                AvatarView(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 14) /// adding the extra 14 (default to 16 + 14 = 30 which is the origin of the  scrollview)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        SectionView()
                    }
                }
                .padding(30)
                .padding(.bottom, 30) // will help the bottom drop shadow be more visible
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ///
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Prototypes designs in Swift UI")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image("Logo1")
            }
            
            Text("18 Sections")
                .frame(maxWidth: .infinity, alignment: .leading) /// this will extend the text to fit the max width of its container
            
            
            
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(Color("card1"))
        .cornerRadius(30)
            // contextual shadow
            .shadow(color: Color("card1").opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

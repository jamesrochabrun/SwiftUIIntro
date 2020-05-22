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
 
  Double(geometry.frame(in: .global).minX) means :: gets the frame value of the card = self.view.frame.minX
 */

import SwiftUI

struct HomeView: View {
    
    /// Bindings
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
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            SectionView(section: item)
                                /// One cool trick to avoid the rotation in the first card is substracting the spacing hard coded value that comes from the padding
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), /// negative or positive changes the animation
                                                        axis: (x: 0, y: 10.0, z: 0)) // setting the axis values to 0 disables the movement in that angle
                        }
                        .frame(width: 275, height: 275)
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
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    
    /// Dependency injection
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text)
                .frame(maxWidth: .infinity, alignment: .leading) /// this will extend the text to fit the max width of its container
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
            // contextual shadow
            .shadow(color: Color("card1").opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

// MARK:- Data model

struct Section: Identifiable {
    
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in Swfi", text: "18 sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card5")
), color: Color("card1")),
     Section(title: "Prototype designs in Swfi", text: "18 sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")
     ), color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))),
      Section(title: "Prototype designs in Swfi", text: "18 sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card6")
      ), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
]




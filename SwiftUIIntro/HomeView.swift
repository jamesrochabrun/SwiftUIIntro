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
 - shadows need to be applied after clipping shapes.
 */

import SwiftUI

struct HomeView: View {
    
    //MARK:- Bindings
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    
    // MARK:- States
    @State var showUpdate = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: {
                        self.showUpdate.toggle()
                    }) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                        /// Modal presentations
                        .sheet(isPresented: $showUpdate) {
                            UpdateList()
                    }
                }
                .padding(.horizontal)
                    .padding(.leading, 14) /// adding the extra 14 (default to 16 + 14 = 30 which is the origin of the  scrollview)
                    .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30) // this will help with the shadow!!!
                        .onTapGesture {
                            self.showContent = true
                    }
                }
                
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
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                /// Adding an item from the datasource.
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    
    /// Dependency injection
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
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
        .frame(width: width, height: height)
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




struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), color2: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), width: 44, heigth: 44, percentage: 68, show: .constant(true))
                    .animation(Animation.easeInOut.delay(0.3))
                VStack {
                    // Bold should be applied before the modifier
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 min").modifier(FontModifier(style: .caption))
                }
                //            .modifier(FontModifier())
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 32, heigth: 32, percentage: 45, show: .constant(true))
                    .animation(Animation.easeInOut.delay(0.3))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), color2: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), width: 32, heigth: 32, percentage: 50, show: .constant(true))
                    .animation(Animation.easeInOut.delay(0.3))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}

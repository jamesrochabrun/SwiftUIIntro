//
//  Home.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/22/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

/**
 
 - Every view added it alwasy will use the safe areas by default.
 - using  .edgesIgnoringSafeArea(.all) to the container will make every sub view ignore safe areas.
 - not to the container!
 - suggestion: apply offset before rotation modifyers
 */

struct Home: View {
    
    @State var showProfile = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            /// Disabling safe arears
                .edgesIgnoringSafeArea(.all)
                        
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                    Button(action: {
                        self.showProfile.toggle()
                    }) {
                        Image("Avatar") // can be a text also
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
                Spacer()
            }
                .padding(.top, 44) /// 44 is been used here as the status bar height. ?? not cool will be a problem in iphone 8 with no notches.
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 20, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            MenuView()
                .offset(y: showProfile ? 0 : 600)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

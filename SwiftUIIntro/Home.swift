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
 - .background(Color.black.opacity(0.001)) 0r .background(Color.clear) setting it to 0 will make it not interactive
 - the animtion modifyiers does not go chained to the festure but to the list of modifyiers of the view.
 - view state height can be used to apply in corner radius, opacity etc.
 */

struct Home: View {
    
    @State var showProfile = false
    @State var viewState: CGSize = .zero
    
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
                /// - 10 will add that depth effect in the #D
                /// dividing by 10 the animation is less aggressive because is kind of doing the 10 % of the dragging translation value
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10.0 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            MenuView()
                .background(Color.black.opacity(0.001)) // kind of user interaction enabled?
                
                .offset(y: showProfile ? 0 : 1000)
                .offset(y: viewState.height) // allows dragging listens to the drag change
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) // you add the animation chaining the modifyiers
                .onTapGesture {
                    self.showProfile.toggle()
            }
            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                }.onEnded { value in
                    /// logic to dismiss card.
                    if self.viewState.height > 50 {
                        self.showProfile = false
                    }
                    self.viewState = .zero
                    
                }
            )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

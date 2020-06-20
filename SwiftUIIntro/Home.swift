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
 - passign states trough components:
    1 - create a Binding variable in the component
    2 -  pass the state to the binding prefixing with $
 
 -  Using bindings and states, child can contain a Binding that can change with a gesture, if parent has a State and is passed as the binding of the child it will act like a delegate'ish.
 
 for example `HomeView` has a `@Binding var showContent: Bool`
 and `Home` has `    @State var showContent = false`
 Then we need to `HomeView(showProfile: $showProfile, showContent: $showContent)` to bind the state
 
 /// Addign a backgorund view to a view just need `Color.black.edgesIgnoringSafeArea(.all)`
`
 `Transitions`
 
 will only work if there is no backgorund like:
 
 ```
 Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
           /// Disabling safe arears
               .edgesIgnoringSafeArea(.all)
 
 or
 
 .background(Color.white) inside `HomeView

 ```
 
 .transition(.move(edge: .top))
 .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
 */

struct Home: View {
    
    @State var showProfile = false
    @State var viewState: CGSize = .zero
    @State var showContent = false

    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
                /// Disabling safe arears
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44) /// 44 is been used here as the status bar height. ?? not cool will be a problem in iphone 8 with no notches.
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.white)
            )
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
                
                .offset(y: showProfile ? 0 : screen.height)
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
            
            /// If statetmet  in Swift UI
            if showContent {
                /// Adding a background view
                Color.white.edgesIgnoringSafeArea(.all)
                ContentView()
                VStack { /// Trick for placing a button in the top right corner!
                    
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                    // Animating transitions!
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
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
}

// MARK:- Global 
let screen = UIScreen.main.bounds

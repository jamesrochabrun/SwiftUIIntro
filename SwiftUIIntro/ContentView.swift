//
//  ContentView.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/19/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

// MARK:- Rules

/*
 Rules:
 - Order of modifiers are hugely important
 - modifiers should not be part of the component
 - Build Small components that can be reused.
 - Naming conventions custom + view and unique
  -start from front to back ideally small components
 - always add the padding before the backgorund
- Add Spacer to display UI on full space then use offsets to position it
 - Spacing bewteen elements in a stack can be defined by Stack(spacing: value)
 -  when animating the order is very important also, start with the offset and animation if a translation is needed.
 - you can repeat modifyiers!
 - you can modify different states at the same time and will perform the action
 */

// MARK:- Content
struct ContentView: View {
    
    // MARK:- States
    @State var show = false
    @State var viewState: CGSize = .zero
    @State var showCard = false
    @State var bottomState: CGSize = .zero
    @State var showFull: Bool = false
    
    //MARK:- Body
    var body: some View {
        ZStack {
            
            /// Adding it a in HStack will facilitate layout
            /// This will push the text to the top
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
                      //  .speed(2)
                       // .repeatCount(3)
            ) // default looks like easeInOut ~).4
            
            BackCardView()
                /// Orde of modifyiersr is very imporant!
                .frame(width: showCard ? 300 : 340.0, height: 220.0)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0)) // avoiding rotation in show card
                .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0)) /// setting an axis to 0 will skip the degrees rotation effect for that axis
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.5))
            
            BackCardView()
                .frame(width: 340.0, height: 220.0)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95) // resetting the scale
                .rotationEffect(.degrees(show ? 0 : 5))
                  .rotationEffect(.degrees(showCard ? -5 : 0)) // avoiding rotation in show card
                .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0)) /// setting an axis to 0 will skip the degrees rotation effect for that axis
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.3))
            
            CardView()
                .padding(.horizontal, 20) //default recommended of 16
                .padding(.top, 20)
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous)) // smoot corners
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height) /// adding this modifyier before to avoid lag in animation when dragging
                .offset(y: showCard ? -100 : 0)
                /**
                 - response: less is less lag
                 - dampingFraction: resistance bigger number less bounce
                 - blendDuration: transition between animation cues.
                 */
                .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0))
                .blendMode(.hardLight)
                .onTapGesture {
                    self.showCard.toggle() // swift 3? maybe implicit self is gone?
            }
            .gesture(
                DragGesture().onChanged { value in
                    /// Modifying multiple states is possible!
                    self.viewState = value.translation
                    self.show = true
                }
                .onEnded { _ in
                    self.viewState = .zero
                    self.show = false
                }
            )
            
            Text("Value \(bottomState.height)")
                .offset(y: -300)
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .gesture(
                DragGesture().onChanged { value in
                    self.bottomState = value.translation
                    if self.showFull {
                        self.bottomState.height += -300
                    }
                    if self.bottomState.height < -300 {
                        self.bottomState.height = -300
                    }
                }
                .onEnded { value in
                    if self.bottomState.height > 50  {
                        self.showCard = false
                    }
                    if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                        self.bottomState.height = -300
                        self.showFull = true
                    } else {
                        self.bottomState = .zero
                        self.showFull = false
                    }
                }
            )
        }
    }
}

// MARK:- Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK:- Components
struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hello, World!").font(.title).fontWeight(.semibold).foregroundColor(Color.white)
                    Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40.0, height: 6.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .opacity(0.1)
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galle")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            Spacer() // push the text to the top!
        }
            .padding(.top, 8) // spaces the little rectangle from the text vertically
            .padding(.horizontal, 20) // spaces horizontally
            .frame(maxWidth: .infinity) // makes the view full width of the container.
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
    }
}

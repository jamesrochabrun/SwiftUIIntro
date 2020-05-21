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
 
 */

// MARK:- Content
struct ContentView: View {
    
    // MARK:- States
    @State var show = false
    
    //MARK:- Body
    var body: some View {
        ZStack {
            
            /// Adding it a in HStack will facilitate layout
            /// This will push the text to the top
            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default) // looks like easeInOut ~).4
            
            BackCardView()
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotation3DEffect(.degrees(10), axis: (x: 10.0, y: 0, z: 0)) /// setting an axis to 0 will skip the degrees rotation effect for that axis
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.5))
            
            BackCardView()
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotation3DEffect(.degrees(5), axis: (x: 10.0, y: 0, z: 0)) /// setting an axis to 0 will skip the degrees rotation effect for that axis
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.3))
            
            CardView()
                .blendMode(.hardLight)
                .onTapGesture {
                    self.show.toggle() // swift 3? maybe this is gone?
            }
            
            BottomCardView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
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
            .padding(.horizontal, 20) //default recommended of 16
            .padding(.top, 20)
            .frame(width: 340.0, height: 220.0)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
            /// Orde of modifyiersr is very imporant!
            .frame(width: 340.0, height: 220.0)
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
            .offset(x: 0, y: 500.0)
    }
}

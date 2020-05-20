//
//  ContentView.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/19/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            .frame(width: 300.0, height: 220.0)
            .background(Color.blue)
            .cornerRadius(20)
            .shadow(radius: 20)
            .offset(x: 0, y: -20)
            
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

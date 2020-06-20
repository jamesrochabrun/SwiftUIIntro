//
//  CourseList.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 6/19/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

///**
///When you want to extract a subview it always needs to have a container.
///
///Better way to make a view fit the screen is use .infinity as `maxWidth` or `maxHeight` instead of screen.width or height
///.infinity respects safe area so if we want to fit the full screen we need to apply a modifyer of
///*/

struct CourseList: View {
    var body: some View {
        CourseView()
//        VStack {
//            CourseView()
//        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Swift UI Advanced")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.white)
                    Text("30 Sections")
                        .foregroundColor(Color.white.opacity(0.7))
                }
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Logo1"))
            }
            Spacer()
            Image(uiImage: #imageLiteral(resourceName: "Card2"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 140.0, alignment: .top)
        }
            .padding(show ? 20 : 30) /// add padding internally
            .padding(.top, show ? 30 : 0)
            // bad
            // .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            // good
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280)
            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: (Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).opacity(0.3)), radius: 20, x: 0, y: 20)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .onTapGesture {
                self.show.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

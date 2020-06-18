//
//  RingView.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 6/17/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

///**
///  .trim `from` 0.2 represents the 80 % and so on
///
///  Modifyers: when a modifyier is applied to a container it is applied to all its childrens, but when a children has  a modifyer it will have PRIORITY
///
///*/

struct RingView: View {
    
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 300.0
    var heigth: CGFloat = 300.0
    var percentage: CGFloat = 44
    
    @Binding var show: Bool
    
    var body: some View {
        /// Declaring variables inside the body like view did load?
        
        let multiplier = width / 44.0
        let progress = 1 - percentage / 100

        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: heigth)
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
            )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: heigth)
                .shadow(color: Color(color1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            Text("\(Int(percentage)) %")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
            }
        }
    }
}

//**/

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        /// Default value to satisfy the preview Because of the Binding.
        RingView(show: .constant(true))
    }
}

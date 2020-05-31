//
//  UpdateList.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/22/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    
    var body: some View {
        NavigationView { // navigation controller
            List(updateData) { update in
                /// UI that we want to present
                NavigationLink(destination: UpdateDetail(update: update)) {
                    
                    /// cells
                    HStack {
                        
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 4)
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            Text(update.text)
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            
                            Text(update.date)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary) // adaptive to dark mode
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle(Text("updates"))
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}


// MARK:- Data Model
struct Update: Identifiable {
    
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "Swift UI", text: "some text more than 2 lines what can i say", date: "may 25")
]

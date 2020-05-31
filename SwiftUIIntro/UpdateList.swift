//
//  UpdateList.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/22/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI

/**
 To pefrom actions like swipe to delet grap the inner list in a for loop insetad of this
 
 ```
 List (store.updates)  { update in
 }
 ```
 
 like this...
 
 ```
 List {
 /// UI that we want to present
 ForEach(store.updates) { update in`
 ```
 
 `EditButton` is available in Swift UI for free.
 
 */

struct UpdateList: View {
    
    // Store combine
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "Swift UI clone", text: "some text more than 2 lines what can i say", date: "may 25"))
    }
    
    var body: some View {
        NavigationView { // navigation controller
            List {
                /// UI that we want to present
                ForEach(store.updates) { update in
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
                    // swipe to delete
                    .onDelete { index in
                        self.store.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle(Text("updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add update")
            }, trailing: EditButton())
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

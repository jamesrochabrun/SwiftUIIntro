//
//  UpdateStore.swift
//  SwiftUIIntro
//
//  Created by James Rochabrun on 5/31/20.
//  Copyright © 2020 James Rochabrun. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    
    @Published var updates: [Update] = updateData
    
    
}

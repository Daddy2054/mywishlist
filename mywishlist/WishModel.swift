//
//  WishModel.swift
//  mywishlist
//
//  Created by Jean on 29/11/24.
//

import Foundation
import SwiftData


@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

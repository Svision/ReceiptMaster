//
//  Item.swift
//  ReceiptMaster
//
//  Created by Changhao Song on 2022-06-06.
//

import Foundation
import SwiftUI

class Item {
    let HST = 0.13
    let id: UUID
    var name: String
    var price: Float
    var tax: Bool
    var splits: [Color]
    
    init(name: String, price: Float, tax: Bool) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.tax = tax
        self.splits = []
    }
}

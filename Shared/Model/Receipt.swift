//
//  Receipt.swift
//  ReceiptMaster
//
//  Created by Changhao Song on 2022-06-06.
//

import Foundation
import Vision
import UIKit

class Receipt {
    let id: UUID
    let receiptImage: UIImage
    var items: [Item]
    var total: Float
    var numberSplits: Int
    
    init(receiptImage: UIImage) {
        self.id = UUID()
        self.receiptImage = receiptImage
        self.items = []
        self.total = 0.0
        self.numberSplits = 0
    }
    
    func processReceipt() {
        ReceiptOCR.processReceipt(receipt: self, receiptImage: self.receiptImage)
    }
    
    func addItem(_ item: Item) {
        self.items.append(item)
    }
}

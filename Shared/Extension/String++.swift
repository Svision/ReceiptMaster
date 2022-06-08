//
//  String++.swift
//  ReceiptMaster
//
//  Created by Changhao Song on 2022-06-06.
//

import Foundation

extension String {
    var isPrice: Bool {
        if self.contains(".") {
            for ch in self {
                if (!ch.isNumber && ch != "." && ch != " " && ch != "H" && ch != "-") {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func formatToPrice()  -> Float {
        if (self.isPrice) {
            var formattedString = self.replacingOccurrences(of: " ", with: "")
            formattedString = formattedString.replacingOccurrences(of: "H", with: "")
            if formattedString.contains("-") {
                formattedString = formattedString.replacingOccurrences(of: "-", with: "")
                if Float(formattedString) != nil {
                    return -Float(formattedString)!
                }
                else {
                    return 0.0
                }
            }
            else {
                return Float(formattedString)!
            }
        }
        return 0.0
    }
    
    func hasTax() -> Bool {
        return self.contains("H")
    }
}

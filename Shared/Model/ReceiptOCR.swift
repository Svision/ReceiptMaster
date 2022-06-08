//
//  ReceiptOCR.swift
//  ReceiptMaster
//
//  Created by Changhao Song on 2022-06-06.
//

import Foundation
import UIKit
import Vision

class ReceiptOCR {
    static func processReceipt(receipt: Receipt, receiptImage: UIImage) {
        // Get the CGImage on which to perform requests.
        guard let cgImage = receiptImage.cgImage else { return }

        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)

        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    static private func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        // Process the recognized strings.
        processResults(recognizedStrings)
    }
    
    static private func processResults(_ recognizedStrings: [String]) {
//        ["COSTCO", "WHOLESALE", "Thorncliffe Park #1316", "42", "Overlea Blvd", "Toronto, ON M4H 1 B8", "V3 Member 111933629773", "Www.WBottom of Basket/*MAMMON?M", "7774269 BOUNTY PLUS", "1669547", "85 DIET COKE", "24.99", "347937", "TPD/7774269", "5.00-", "ROTI", "***********BORr", "CHICKEN", "11.99", "1004032 WATERMELON", "7.99", "IrII", "Count 3 XXXXXXXXXXXX**", "1440696 WW BODYSCALE", "1638885 TIDE PODS", "12.99", "1638885", "19.99", "TIDE", "PODS", "TOTAL NUMBER OF ITEMS SOLD", "37.99", ": TI", "37.99 H", "7", "1517853 CREST", "WHTSTP", "59.99 H", "1595625 GILLETTE", "628368", "LISTERINE UC", "70608 ICED TEA", "555303 KS HAM2X500G", "59, 99 M H", "13.99", "3161251 UNSTOPABLES", "9.89", "1668644 TPD/3161251", "12.99", "435710 NB HAIR SKIN", "21.99", "4.50-", "1664745 TPD/43571", "330328 EGGS 2 X 12", "14.49", "3.00-", "330328 EGGS . X 12", "6.29", "rIII", "5058019 SLICE VARIET", "6.29", "1669022 TPD/5058019", "14.99", "4149 PALM LEAF", "3.00-", "283301 CHOCOLATINE", "6.99", "1351953 POPCORNERS", "6.99", "4165758 KS COLD BREW", "6.99", "21.99", "H", "313973 EGG WHITES", "1636229 DB POPCORN", "7.79", "1609698", "2PK", "MISTO", "6.49 H", "40791 RIB STK BNLS", "22.99 I:", "33157 SHORT RIBS", "38.87", "33157 SHORT RIBS", "46.91", "5051502 CONNIE CKN B", "41.71", "1480888 BB BIKINI", "15.99", "100721 WAFFLES", "18.99", "H", "116218 BAGELS", "6.99", "1579923 8PK SOCKS", "7.99", "3879 CELERY STICK", "16.99", "H", "183409 SMKD FARM SA", "5.99", "1486202 CREAM CHEESE", "16.99", "1594987 DARK MAPLE", "4.99", "1426213 JOE BOXER 4P", "11.49", "18.99", "10611 SAUSAGE", "H", "22354 DRUMSTICKS", "14.51", "77053 GRAPE TOMATO", "19.74", "1101517 TRIO LETTUCE", "6.99", "26002 SPLIT WING", "3.99", "27003 STRAWBERRIES", "24.64", "512515 ORG STRAWBRY", "4.99", "1270656 BROOKSIDE VP", "6.99", "12.89", "H", "SUBTOTAL", "787.19", "TAX", "52.42", "**** TOTAL", "8396", "XXXXXXXXXXXX1095", "ACCT: INTERAC CHEQUING", "DATE/TIME: 2022/06/05 14:48:15", "C", "REFERENCE #: 66454822-0010010970", "015097", "Invoice Number:", "- Interac"]
        
        var i = 0
        var first_item_i = -1
        while (i < recognizedStrings.count) {
            let rs = recognizedStrings[i]
            if (rs.isPrice && i > 1) {
                if (first_item_i == -1) {
                    first_item_i = i
                }
                
                let name = recognizedStrings[i-1]
                let price = rs.formatToPrice()
                let item = Item(name: name, price: price, tax: rs.hasTax() || recognizedStrings[i+1].hasTax())
                print(item.name, "$\(item.price)", item.tax ? "H" : "")
            }
            i += 1
        }
    }
}

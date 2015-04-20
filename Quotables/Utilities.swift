//
//  Sanitizer.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

func sanitizeQuote(quote: String) -> String {
    let regexArray = ["Read more at http.+$"]
    var str = String(quote)
    for regex in regexArray {
        if let match = str.rangeOfString(regex, options: .RegularExpressionSearch){
            str.removeRange(match)
        }
    }

    return str
}


func adjustFontSize(label: UILabel, size: CGFloat) {
        let font = label.font.fontWithSize(size)
        label.font = font
}
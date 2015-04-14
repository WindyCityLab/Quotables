//
//  Sanitizer.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import Foundation

class Sanitizer {

    class func sanitizeQuote(quote: String) -> String {
        let regexArray = ["Read more at http.+$"]
        var str = String(quote)
        for regex in regexArray {
            if let match = str.rangeOfString(regex, options: .RegularExpressionSearch){
                str.removeRange(match)
            }
        }

        return str
    }
}
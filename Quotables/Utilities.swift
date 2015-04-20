//
//  Sanitizer.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

func applyRegex(input: String, regex: String) -> String {
    var str = String(input)
    if let match = str.rangeOfString(regex, options: .RegularExpressionSearch){
        str.removeRange(match)
    }

    return str
}

func sanitizeQuote(quote: String) -> String {
    let regexArray = ["Read more at http.+$"]
    var str = String(quote)
    for regex in regexArray {
        str = applyRegex(str, regex)
    }

    return str
}

func adjustFontSize(label: UILabel, size: CGFloat) {
        let font = label.font.fontWithSize(size)
        label.font = font
}

func getPersonName(str: String) -> String {
    let options: NSLinguisticTaggerOptions = .OmitWhitespace | .OmitPunctuation | .JoinNames
    let schemes = NSLinguisticTagger.availableTagSchemesForLanguage("en")
    let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
    var personName = ""
    tagger.string = str
    tagger.enumerateTagsInRange(NSMakeRange(0, (str as NSString).length), scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: options) { (tag, tokenRange, sentenceRange, _) in
        let token = (str as NSString).substringWithRange(tokenRange)
        if tag == "PersonalName" {
            personName = token
        }
    }

    return personName
}
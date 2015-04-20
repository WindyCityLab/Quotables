//
//  Sanitizer.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

let EXCLUDE_REGEX = ["Read more at http.+$", "Excerpt From:.+$"]
let EXCLUDE_CHARS = ["\n", "“", "”", "―"]

let NLP_ENGLISH = "en"
let POS_PERSON = "PersonalName"

let SINGLE_SPACE = " "

func adjustFontSize(label: UILabel, size: CGFloat) {
    let font = label.font.fontWithSize(size)
    label.font = font
}

func removeRegex(input: String, regex: String) -> String {
    var str = String(input)
    if let match = str.rangeOfString(regex, options: .RegularExpressionSearch){
        str.removeRange(match)
    }

    return str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
}

func sanitizeQuote(quote: String) -> String {
    var str = String(quote)
    for target in EXCLUDE_CHARS {
        str = str.stringByReplacingOccurrencesOfString(target, withString: SINGLE_SPACE)
    }

    for regex in EXCLUDE_REGEX {
        str = removeRegex(str, regex)
    }

    return str
}

func getPersonName(str: String) -> String {
    let options: NSLinguisticTaggerOptions = .OmitWhitespace | .OmitPunctuation | .JoinNames
    let schemes = NSLinguisticTagger.availableTagSchemesForLanguage(NLP_ENGLISH)
    let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
    var personName = ""
    tagger.string = str
    tagger.enumerateTagsInRange(NSMakeRange(0, (str as NSString).length), scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: options) { (tag, tokenRange, sentenceRange, _) in
        let token = (str as NSString).substringWithRange(tokenRange)
        if tag == POS_PERSON {
            personName = token
        }
    }

    return personName
}

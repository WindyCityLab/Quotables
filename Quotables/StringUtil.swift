//
//  Sanitizer.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//
import Foundation


func removeRegex(input: String, regex: String) -> String {
    let regex:NSRegularExpression  = NSRegularExpression(
        pattern: regex,
        options: NSRegularExpressionOptions.CaseInsensitive,
        error: nil)!

    let range = NSMakeRange(0, count(input))
    return regex.stringByReplacingMatchesInString(input, options: NSMatchingOptions.allZeros, range:range, withTemplate: "")
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
    var personName = ANON
    tagger.string = str
    tagger.enumerateTagsInRange(NSMakeRange(0, (str as NSString).length), scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: options) { (tag, tokenRange, sentenceRange, _) in
        let token = (str as NSString).substringWithRange(tokenRange)
        if tag == POS_PERSON || tag == POS_PLACE {
            personName = token
        }
    }

    return personName
}

func getSHA1(input: String) -> String {
    let data = input.dataUsingEncoding(NSUTF8StringEncoding)!
    var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
    CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
    let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
    for byte in digest {
        output.appendFormat("%02x", byte)
    }
    return output as String
}

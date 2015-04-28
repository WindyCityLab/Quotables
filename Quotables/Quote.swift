//
//  Quote.swift
//  WindyCityLabs
//
//  Created by Fiaz Sami on 4/13/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import Foundation
import Parse


class Quote : PFObject, PFSubclassing {
    @NSManaged var text: String!
    @NSManaged var author: String!
    @NSManaged var foundBy: String!

    override class func initialize() {
        registerSubclass()
    }

    class func parseClassName() -> String {
        return "Quote"
    }

    func getAuthor() -> String {
        if (self.author != nil) {
            return author
        } else {
            return "EDIT REQUIRED"
        }
    }

    class func makeQuote(input: String) -> Quote {
        let quote = Quote()
        let text = sanitizeQuote(input)

        if let foundBy = NSUserDefaults(suiteName: SUITE_NAME)!.objectForKey(USER_NAME) as? String {
            quote.foundBy = foundBy
        }
        
        quote.author = getPersonName(text)
        quote.text = removeRegex(text, quote.author)
        return quote
    }
}

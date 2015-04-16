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
    @NSManaged var uniqueContent: String!

    override class func initialize()
    {
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
}

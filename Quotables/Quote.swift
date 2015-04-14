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
    @NSManaged var text: String
    @NSManaged var author: String

    override class func load()
    {
        self.registerSubclass()
    }

    class func parseClassName() -> String! {
        return "Quote"
    }
}

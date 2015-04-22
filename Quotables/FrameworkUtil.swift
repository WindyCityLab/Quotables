//
//  FrameworkUtils.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/22/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import Foundation
import Parse
import Fabric
import Crashlytics

func registerFrameworks() {
    Parse.setApplicationId(PARSE_APP_ID, clientKey: PARSE_CLIENT_ID)
    Fabric.with([Crashlytics()])
}

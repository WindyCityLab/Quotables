//
//  CloudKitUtil.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/22/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import Foundation
import CloudKit

func processCloudKitRecordId(completionFunc: String -> Void) {
    let defaultContainer = CKContainer.defaultContainer()
    defaultContainer.fetchUserRecordIDWithCompletionHandler { (recordId, error) -> Void in
        if error != nil {
            defaultContainer.discoverUserInfoWithUserRecordID(recordId, completionHandler: {userInfo, error in
                completionFunc("firstName: \(userInfo.firstName) lastName: \(userInfo.lastName)")
            })
        }
    }
}
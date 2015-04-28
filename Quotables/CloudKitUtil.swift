//
//  CloudKitUtil.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/22/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import Foundation
import CloudKit

func requestCloudKitPermission() {
    CKContainer.defaultContainer().requestApplicationPermission(CKApplicationPermissions.PermissionUserDiscoverability,
        completionHandler: {
            applicationPermissionStatus, error in
             processCloudKitRecordId()
    })
}

func processCloudKitRecordId() {
    let defaultContainer = CKContainer.defaultContainer()
    defaultContainer.fetchUserRecordIDWithCompletionHandler { (recordId, error) -> Void in
        if error == nil {
            defaultContainer.discoverUserInfoWithUserRecordID(recordId, completionHandler: {userInfo, error in
                if error == nil {
                    let userName = "\(userInfo.firstName.capitalizedString) \(userInfo.lastName.capitalizedString)"
                    if let userDefaults = NSUserDefaults(suiteName: SUITE_NAME) {
                        userDefaults.setObject(userName, forKey: USER_NAME)
                        userDefaults.synchronize()
                    }
                } else {
                    println("CloudKit Error :: \(error)")
                }
            })
        } else {
            println("CloudKit Error :: \(error)")
        }
    }
}



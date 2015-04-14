//
//  TodayViewController.swift
//  QuotablesToday
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit
import NotificationCenter
import Parse

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet var labelQuote: UILabel!
    @IBOutlet var buttonSave: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        Parse.setApplicationId("OL0i1OhDkRscie1SlaqRinQsn78CwY4gL1vThHaF", clientKey: "vIuRlq40qlDDCYffI8yeTd7aixpQB4vGVnKYoBKu")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        labelQuote.text = Sanitizer.sanitizeQuote(UIPasteboard.generalPasteboard().string!)
        if (labelQuote.text? == nil) {
            buttonSave.enabled = false
        } else {
            buttonSave.enabled = true
        }

        completionHandler(NCUpdateResult.NewData)
    }

    



    @IBAction func onSaveButtonTap(sender: UIButton) {
        let quote = Quote()
        quote.text = labelQuote.text!
        quote.author = "EDIT REQUIRED"
        quote.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil && !success {
                println("ERROR SAVING QUOTE FROM TODAY EXTENSION")
            } else {
                println("SAVING SUCCESSFUL")
                self.labelQuote.text = ""
                self.buttonSave.enabled = false
                UIPasteboard.generalPasteboard().string = ""
            }
        }
    }
}

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

        buttonSave.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        if let text = UIPasteboard.generalPasteboard().string {
            if let text = UIPasteboard.generalPasteboard().string {
                let quote = Quote.makeQuote(text)
                if quote.author.isEmpty {
                   quote.author = "Anonymous"
                }

                if !quote.text.isEmpty {
                    labelQuote.text = "\(quote.text)\n\n\(quote.author)"
                    buttonSave.hidden = false
                }

            }
        }

        completionHandler(NCUpdateResult.NewData)
    }

    @IBAction func onSaveButtonTap(sender: UIButton) {
        let quote = Quote.makeQuote(labelQuote.text!)
        quote.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil && !success {
                println("ERROR SAVING QUOTE FROM TODAY EXTENSION")
            } else {
                println("SAVING SUCCESSFUL")
                self.labelQuote.text = ""
                self.buttonSave.hidden = true
            }
        }

    }
    
    @IBAction func onEditButtonTap(sender: AnyObject) {
        extensionContext?.openURL(NSURL(fileURLWithPath: "quotable://home")!, completionHandler: nil)
    }
}

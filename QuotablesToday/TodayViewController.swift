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

    var quote = Quote(className: "Quote")

    override func viewDidLoad() {
        super.viewDidLoad()
        Parse.setApplicationId(PARSE_APP_ID, clientKey: PARSE_CLIENT_ID)

        buttonSave.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        if let text = UIPasteboard.generalPasteboard().string {
            if let text = UIPasteboard.generalPasteboard().string {
                quote = Quote.makeQuote(text)
                if quote.author.isEmpty {
                   quote.author = ANON
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
        quote.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil && !success {
                println("ERROR: \(error)")
            } else {
                self.labelQuote.text = ""
                self.buttonSave.hidden = true
            }
        }

    }
    
    @IBAction func onEditButtonTap(sender: AnyObject) {
        extensionContext?.openURL(NSURL(fileURLWithPath: APP_URL)!, completionHandler: nil)
    }
}

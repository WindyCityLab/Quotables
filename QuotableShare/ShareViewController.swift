//
//  ShareViewController.swift
//  QuotableShare
//
//  Created by Fiaz Sami on 4/14/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit
import Social
import Parse

class ShareViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var fieldQuote: UITextView!
    @IBOutlet var fieldAuthor: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        Parse.setApplicationId("OL0i1OhDkRscie1SlaqRinQsn78CwY4gL1vThHaF", clientKey: "vIuRlq40qlDDCYffI8yeTd7aixpQB4vGVnKYoBKu")
        fieldAuthor.delegate = self

        if let text = UIPasteboard.generalPasteboard().string {
            let quote = Quote.makeQuote(text)
            fieldQuote.text = quote.text
            fieldAuthor.text = quote.author
        }

        fieldAuthor.becomeFirstResponder()

        fieldAuthor.keyboardAppearance = UIKeyboardAppearance.Dark
        fieldQuote.keyboardAppearance = UIKeyboardAppearance.Dark
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        saveQuote()
        return true
    }

    @IBAction func onButtonSaveTap(sender: AnyObject) {
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        saveQuote()
    }

    @IBAction func onButtonCancelTap(sender: AnyObject) {
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }

    func saveQuote() {
        let quote = Quote(className: "Quote")
        quote.text = fieldQuote.text
        quote.author = fieldAuthor.text
        quote.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil {
                println(error)
            }
        }
    }
    
}

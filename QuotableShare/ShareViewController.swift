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
        fieldQuote.text = Sanitizer.sanitizeQuote(UIPasteboard.generalPasteboard().string!)
        fieldQuote.becomeFirstResponder()


        fieldAuthor.keyboardAppearance = UIKeyboardAppearance.Dark
        fieldQuote.keyboardAppearance = UIKeyboardAppearance.Dark
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        saveQuote()
        return true
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

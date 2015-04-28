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

    var currentQuote: Quote = Quote(className: "Quote")

    override func viewDidLoad() {
        super.viewDidLoad()
        registerFrameworks()

        fieldAuthor.delegate = self

        if let text = UIPasteboard.generalPasteboard().string {
            currentQuote = Quote.makeQuote(text)
            fieldQuote.text = currentQuote.text
            fieldAuthor.text = currentQuote.author
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
        currentQuote.text = fieldQuote.text
        currentQuote.author = fieldAuthor.text
        currentQuote.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil {
                println(error)
            }
        }
    }
    
}

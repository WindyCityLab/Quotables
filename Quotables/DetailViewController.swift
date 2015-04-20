//
//  DetailViewController.swift
//  WindyCityLabs
//
//  Created by Fiaz Sami on 4/13/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func updateTable(remoteUpdate: Bool)
}

class DetailViewController : UIViewController, UITextFieldDelegate {

    var quote: Quote = Quote(className: "Quote")
    var delegate: DetailViewControllerDelegate?
    var refreshData = false
    var increaseFontSize: Bool = false

    @IBOutlet var fieldQuote: UITextView!
    @IBOutlet var fieldAuthor: UITextField!

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadNavbarTheme(self.view, self.navigationController!.navigationBar)

        if minimumSizeExceeded(self.view) {
            adjustFontSize(fieldQuote, 30)
            adjustFontSize(fieldAuthor, 25)
        }

        fieldAuthor.delegate = self
        fieldQuote.text = quote.text
        fieldAuthor.text = quote.author
        fieldAuthor.becomeFirstResponder()

        fieldAuthor.keyboardAppearance = UIKeyboardAppearance.Dark
        fieldQuote.keyboardAppearance = UIKeyboardAppearance.Dark

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Palatino", size: 17.0)!]
        saveButton.setTitleTextAttributes(titleDict as [NSObject : AnyObject], forState: .Normal)

        deleteButton.hidden = refreshData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onButtonSaveTap(sender: AnyObject) {
        saveQuote()
    }

    @IBAction func onButtonDeleteTap(sender: AnyObject) {
        quote.deleteInBackgroundWithBlock { (success, error) -> Void in
            if error != nil || !success {
                println(error)
            } else {
                self.dismissView(true)
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveQuote()
        return true
    }

    func saveQuote() {
        quote.text = fieldQuote.text
        quote.author = fieldAuthor.text
        quote.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil || !success {
                println(error)
            } else {
                self.dismissView(true)
            }
        }
    }

    func dismissView(remoteUpdate: Bool) {
        delegate?.updateTable(remoteUpdate)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}

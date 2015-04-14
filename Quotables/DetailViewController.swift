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

    var quote: Quote = Quote()
    var delegate: DetailViewControllerDelegate?
    var refreshData = false

    @IBOutlet var fieldQuote: UITextView!
    @IBOutlet var fieldAuthor: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        fieldAuthor.delegate = self
        fieldQuote.text = quote.text
        fieldAuthor.text = quote.author
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onButtonDismissTap(sender: UIButton) {
        dismissView(false)
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
                self.dismissView(self.refreshData)
            }
        }
    }

    func dismissView(remoteUpdate: Bool) {
        delegate?.updateTable(remoteUpdate)
        dismissViewControllerAnimated(true, completion: nil)
    }

}

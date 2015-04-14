//
//  DetailViewController.swift
//  WindyCityLabs
//
//  Created by Fiaz Sami on 4/13/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func updateTable()
}

class DetailViewController : UIViewController, UITextFieldDelegate {

    var quote: Quote = Quote()
    var delegate: DetailViewControllerDelegate?

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
        dismissView()
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
            if error != nil {
                println(error)
            } else {
                self.dismissView()
            }
        }
    }

    func dismissView() {
        delegate?.updateTable()
        dismissViewControllerAnimated(true, completion: nil)
    }

}

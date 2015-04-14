//
//  ViewController.swift
//  WindyCityLabs
//
//  Created by Fiaz Sami on 4/13/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate {

    @IBOutlet var tableQuotes: UITableView!

    var quotes: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadQuotes() {
        let quoteQuery = Quote.query()
        quoteQuery.findObjectsInBackgroundWithBlock { (quoteObjects, error) -> Void in
            if error == nil {
                self.quotes = quoteObjects
                self.tableQuotes.reloadData()
            } else {
                println(error)
            }
        }

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableQuotes.dequeueReusableCellWithIdentifier("QuoteCell", forIndexPath: indexPath) as UITableViewCell
        let quote = quotes[indexPath.row] as Quote

        let labelQuote = self.view.viewWithTag(100) as UILabel
        labelQuote.text = "\"\(quote.text)\""

        let labelAuthor = self.view.viewWithTag(110) as UILabel
        labelAuthor.text = "- \(quote.author)"


        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detail = segue.destinationViewController as DetailViewController
        detail.delegate = self
        if(segue.identifier == "detailQuote") {
            let indexPath = tableQuotes.indexPathForCell(sender as UITableViewCell)
            detail.quote = quotes[indexPath!.row] as Quote
        } else if(segue.identifier == "addQuote") {
            let quote = Quote()
            let pasteBoard = UIPasteboard.generalPasteboard().string
            if pasteBoard != nil {
                quote.text = Sanitizer.sanitizeQuote(pasteBoard!)
            } else {
                quote.text = ""
            }
            quote.author = ""
            detail.quote = quote
            detail.refreshData = true
        }

    }

    func updateTable(remoteUpdate: Bool) {
        if remoteUpdate {
            loadQuotes()
        } else {
            tableQuotes.reloadData()
        }
    }


}


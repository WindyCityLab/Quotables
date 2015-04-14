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
                println(self.quotes.count)
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
        let indexPath = tableQuotes.indexPathForCell(sender as UITableViewCell)
        detail.quote = quotes[indexPath!.row] as Quote

    }

    func updateTable() {
        tableQuotes.reloadData()
    }


}


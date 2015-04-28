//
//  ViewController.swift
//  WindyCityLabs
//
//  Created by Fiaz Sami on 4/13/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit
import CloudKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate {

    @IBOutlet var tableQuotes: UITableView!

    var quotes: NSArray = []
    let refreshControl = UIRefreshControl()
    var increaseFontSize: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        increaseFontSize = minimumSizeExceeded(self.view)

        refreshControl.addTarget(self, action: "refreshQuotes:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableQuotes.addSubview(refreshControl)

        loadNavbarTheme(self.view, self.navigationController!.navigationBar)
        loadQuotes()


        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        requestCloudKitPermission()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.title = ""
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Quotables"
    }


    func refreshQuotes(forControlEvents: UIControlEvents) {
        loadQuotes()
        refreshControl.endRefreshing()
    }

    func loadQuotes() {
        let quoteQuery = Quote.query()
        quoteQuery?.addDescendingOrder("createdAt")
        quoteQuery!.findObjectsInBackgroundWithBlock { (quoteObjects, error) -> Void in
            if error == nil {
                self.quotes = quoteObjects!
                self.tableQuotes.reloadData()
            } else {
                println(error)
            }
        }

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableQuotes.dequeueReusableCellWithIdentifier("QuoteCell", forIndexPath: indexPath) as! UITableViewCell
        let quote = quotes[indexPath.row] as! Quote

        let labelQuote = setLabelTextWithTag(100, text: quote.text)
        let labelAuthor = setLabelTextWithTag(110, text: quote.author)
        let labelFoundBy = setLabelTextWithTag(120, text: getAttribution(quote))

        if increaseFontSize {
            adjustFontSize(labelQuote, 28)
            adjustFontSize(labelAuthor, 24)
            adjustFontSize(labelAuthor, 22)
        }

        return cell
    }

    func getAttribution(quote: Quote) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
        let firstName = quote.foundBy.componentsSeparatedByString(" ")[0]
        return "found by \(firstName) on \(dateFormatter.stringFromDate(quote.createdAt!))"
    }

    func setLabelTextWithTag(tag: Int, text: String) -> UILabel {
        let label = self.view.viewWithTag(tag) as! UILabel
        label.text = text
        return label
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detail = segue.destinationViewController as! DetailViewController
        detail.delegate = self

        switch segue.identifier! {
        case "detailQuote":
            let indexPath = tableQuotes.indexPathForCell(sender as! UITableViewCell)
            detail.quote = quotes[indexPath!.row] as! Quote

        case "addQuote":
            if let text = UIPasteboard.generalPasteboard().string {
                detail.quote = Quote.makeQuote(text)
            } else {
                detail.quote = Quote()
            }

            detail.refreshData = true

        default: ()
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


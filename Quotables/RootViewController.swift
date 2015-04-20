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
    let refreshControl = UIRefreshControl()
    var increaseFontSize: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        increaseFontSize = minimumSizeExceeded(self.view)

        refreshControl.addTarget(self, action: "refreshQuotes:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableQuotes.addSubview(refreshControl)

        loadNavbarTheme()
        loadQuotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadNavbarTheme() {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Palatino", size: navbarFontSize())!]
        nav?.titleTextAttributes = titleDict as [NSObject : AnyObject]
    }

    func navbarFontSize() -> CGFloat {
        if increaseFontSize {
            return 30.0
        }

        return 20.0
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

        let labelQuote = self.view.viewWithTag(100) as! UILabel
        labelQuote.text = quote.text

        let labelAuthor = self.view.viewWithTag(110) as! UILabel
        labelAuthor.text = quote.author

        if increaseFontSize {
            adjustFontSize(labelQuote, 28)
            adjustFontSize(labelAuthor, 24)
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detail = segue.destinationViewController as! DetailViewController
        detail.delegate = self
        if(segue.identifier == "detailQuote") {
            let indexPath = tableQuotes.indexPathForCell(sender as! UITableViewCell)
            detail.quote = quotes[indexPath!.row] as! Quote
        } else if(segue.identifier == "addQuote") {
            if let text = UIPasteboard.generalPasteboard().string {
                detail.quote = Quote.makeQuote(text)
            } else {
                detail.quote = Quote(className: "Quote")
            }

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


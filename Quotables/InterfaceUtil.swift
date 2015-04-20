//
//  InterfaceUtil.swift
//  Quotables
//
//  Created by Fiaz Sami on 4/20/15.
//  Copyright (c) 2015 windycitylabs. All rights reserved.
//

import UIKit

func minimumFontSizeForView(width: CGFloat, height: CGFloat) -> (UIView -> Bool) {
    return {view in
        view.frame.width > width || view.frame.height > height
    }
}

let minimumSizeExceeded = minimumFontSizeForView(400, 700)

func loadNavbarTheme(view: UIView, navigationBar: UINavigationBar) {
    navigationBar.barStyle = UIBarStyle.BlackTranslucent

    let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Palatino", size: navbarFontSize(view))!]
    navigationBar.titleTextAttributes = titleDict as [NSObject : AnyObject]
}

func navbarFontSize(view: UIView) -> CGFloat {
    if minimumSizeExceeded(view) {
        return 30.0
    }

    return 20.0
}

func adjustFontSize(textView: UITextView, size: CGFloat) {
    textView.font = textView.font.fontWithSize(size)
}

func adjustFontSize(textField: UITextField, size: CGFloat) {
    textField.font = textField.font.fontWithSize(size)
}

func adjustFontSize(label: UILabel, size: CGFloat) {
    label.font = label.font.fontWithSize(size)
}

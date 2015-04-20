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

func adjustFontSize(textView: UITextView, size: CGFloat) {
    textView.font = textView.font.fontWithSize(size)
}

func adjustFontSize(textField: UITextField, size: CGFloat) {
    textField.font = textField.font.fontWithSize(size)
}

func adjustFontSize(label: UILabel, size: CGFloat) {
    label.font = label.font.fontWithSize(size)
}

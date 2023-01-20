//
//  NSAttributedString.swift
//
//
//  Created by Kevin Waltz on 02.03.21.
//  

import UIKit

public extension NSAttributedString {
    convenience init(format: NSAttributedString, args: NSAttributedString...) {
        let mutableNSAttributedString = NSMutableAttributedString(attributedString: format)

        args.forEach { attributedString in
            let range = NSString(string: mutableNSAttributedString.string).range(of: "%@")
            mutableNSAttributedString.replaceCharacters(in: range, with: attributedString)
        }
        
        self.init(attributedString: mutableNSAttributedString)
    }
}

//
//  UIViewController.swift
//  
//
//  Created by Anna Münster on 25.01.23.
//

import UIKit

public extension UIViewController {
    /**
     Find the most top level view controller to avoid "ViewController is already presenting"-Bugs
     */
    static func getTopMostPresentingViewController(viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getTopMostPresentingViewController(viewController: presented)
        } else {
            return viewController
        }
    }
}

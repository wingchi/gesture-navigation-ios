//
//  ViewController.swift
//  GestureNavigationController
//
//  Created by Stephen Wingchi Wong on 10/8/17.
//  Copyright © 2017 S. Wingchi Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GestureNavigationControllerDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gestureNavigationController = navigationController as? GestureNavigationController else { return }
        gestureNavigationController.dataSource = self
    }
    
    // MARK: - GestureNavigationControllerDataSource
    
    func gestureNavigationController(_: GestureNavigationController, viewControllerLeft: UIViewController?) -> UIViewController? {
        let nextViewController = NextViewController(title: "Left")
        return nextViewController
    }
    
    func gestureNavigationController(_: GestureNavigationController, viewControllerRight: UIViewController?) -> UIViewController? {
        let nextViewController = NextViewController(title: "Right")
        return nextViewController
    }
    
    func gestureNavigationController(_: GestureNavigationController, viewControllerAbove: UIViewController?) -> UIViewController? {
        let nextViewController = NextViewController(title: "Above")
        return nextViewController
    }
    
    func gestureNavigationController(_: GestureNavigationController, viewControllerBelow: UIViewController?) -> UIViewController? {
        let nextViewController = NextViewController(title: "Below")
        return nextViewController
    }
    
}


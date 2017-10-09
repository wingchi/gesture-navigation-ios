//
//  GestureNavigationController.swift
//  GestureNavigationController
//
//  Created by Stephen Wingchi Wong on 10/8/17.
//  Copyright © 2017 S. Wingchi Wong. All rights reserved.
//

import UIKit

class GestureNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        switch sender.state {
        case .began, .changed:
            print("TRANSLATION: \(translation)")
        default:
            print("GESTURE RECOGNIZED")
        }
    }
}

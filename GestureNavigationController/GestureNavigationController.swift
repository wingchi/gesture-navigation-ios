//
//  GestureNavigationController.swift
//  GestureNavigationController
//
//  Created by Stephen Wingchi Wong on 10/8/17.
//  Copyright © 2017 S. Wingchi Wong. All rights reserved.
//

import UIKit

protocol GestureNavigationControllerDataSource: AnyObject {
    func gestureNavigationController(_: GestureNavigationController, viewControllerAbove: UIViewController?) -> UIViewController?
    func gestureNavigationController(_: GestureNavigationController, viewControllerBelow: UIViewController?) -> UIViewController?
    func gestureNavigationController(_: GestureNavigationController, viewControllerLeft: UIViewController?) -> UIViewController?
    func gestureNavigationController(_: GestureNavigationController, viewControllerRight: UIViewController?) -> UIViewController?
}

enum PanDirection {
    case up, down, left, right
}

class GestureNavigationController: UINavigationController {

    weak var dataSource: GestureNavigationControllerDataSource? = nil
    var nextVC: UIViewController? = nil
    var panDirection: PanDirection? = nil
    
    let customNavigationAnimationController = CustomNavigationAnimationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
        view.addGestureRecognizer(panGestureRecognizer)
        
        delegate = customNavigationAnimationController
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        handleNavigation(for: sender.state, translation: translation)
    }
    
    func panNextViewController(with translation: CGPoint) {
        guard
            let direction = panDirection,
            nextVC  == nil
            else { return }
        switch  direction {
        case .left:
            nextVC = dataSource?.gestureNavigationController(self, viewControllerRight: topViewController)
        case .right:
            nextVC = dataSource?.gestureNavigationController(self, viewControllerLeft: topViewController)
        case .up:
            nextVC = dataSource?.gestureNavigationController(self, viewControllerBelow: topViewController)
        case .down:
            nextVC = dataSource?.gestureNavigationController(self, viewControllerAbove: topViewController)
        }
        guard let nextVC = nextVC else { return }
        pushViewController(nextVC, animated: true)
    }
    
    // MARK: - Testable
    func handleNavigation(for state: UIGestureRecognizerState, translation: CGPoint) {
        let x = translation.x
        let y = translation.y
        
        switch state {
        case .began:
            guard nextVC == nil else { break }
            if abs(x) > abs(y) && x >= 0 { // pan right
                panDirection = .right
            } else if abs(x) > abs(y) && x < 0 { // pan left
                panDirection = .left
            } else if abs(x) < abs(y) && y >= 0 { // pan down
                panDirection = .down
            } else if abs(x) < abs(y) && y < 0 { // pan up
                panDirection = .up
            }
            panNextViewController(with: translation)
        case .changed:
            panNextViewController(with: translation)
        case .cancelled, .ended, .failed, .possible:
            nextVC = nil
            panDirection = nil
        }
    }
    
}

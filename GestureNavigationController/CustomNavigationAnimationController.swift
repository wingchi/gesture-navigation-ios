//
//  CustomNavigationAnimationController.swift
//  GestureNavigationController
//
//  Created by Stephen Wingchi Wong on 10/31/17.
//  Copyright © 2017 S. Wingchi Wong. All rights reserved.
//

import UIKit

class CustomNavigationAnimationController: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let gestureNavigationController = navigationController as? GestureNavigationController,
            let panDirection = gestureNavigationController.panDirection
            else { return nil }
       return PanAnimatedTransition(panDirection)
    }
}

class PanAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let panDirection: PanDirection
    
    init(_ direction: PanDirection) {
        panDirection = direction
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
        
        toViewController.view.frame = containerView.bounds
        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        let width = containerView.bounds.width
        let height = containerView.bounds.height
        var transform: CGAffineTransform
        switch panDirection {
        case .up:
            transform = CGAffineTransform(translationX: 0, y: height)
        case .down:
            transform = CGAffineTransform(translationX: 0, y: -height)
        case .left:
            transform = CGAffineTransform(translationX: width, y: 0)
        case .right:
            transform = CGAffineTransform(translationX: -width, y: 0)
        }
        toViewController.view.transform = transform
        
        UIView.animate(
            withDuration: 1.0,
            animations: {
                toViewController.view.transform = .identity
            },
            completion: { completed in
                transitionContext.completeTransition(completed)
            }
        )
    }
}

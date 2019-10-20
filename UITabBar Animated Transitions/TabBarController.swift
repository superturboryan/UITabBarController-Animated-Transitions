//
//  ViewController.swift
//  UITabBar Animated Transitions
//
//  Created by Ryan David Forsyth on 2019-10-18.
//  Copyright © 2019 Ryan F. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }

    
    
    
}


//MARK:- Delegate methods
extension TabBarController: UITabBarControllerDelegate, UIViewControllerAnimatedTransitioning {


    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        destination.alpha = 0.0
        destination.transform = .init(scaleX: 1.1, y: 1.1)
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        },
        completion: { transitionContext.completeTransition($0) })
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.15
    }
}

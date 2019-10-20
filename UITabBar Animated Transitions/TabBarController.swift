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
        
        guard let currentVC = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        
        guard let destinationVC = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        print("Going from \(currentVC.value(forKeyPath: "tag")!) to \(destinationVC.value(forKeyPath: "tag")!)")

        destinationVC.alpha = 0.0
        
        let currentVCNumber = currentVC.value(forKeyPath: "tag") as! Int
        let destinationVCNumber = destinationVC.value(forKeyPath: "tag") as! Int
        
        let goingToTheRight = currentVCNumber - destinationVCNumber < 0 ? true : false
        
        if (goingToTheRight) {
            
            destinationVC.transform = .init(translationX: destinationVC.frame.size.width, y: 0)
        }
        else { // goingToTheLeft ...
            
            destinationVC.transform = .init(translationX: -destinationVC.frame.size.width, y: 0)
        }
        
//        destinationVC.transform = .init(scaleX: 0.7, y: 0.7)
        
        transitionContext.containerView.addSubview(destinationVC)

        UIView.animate(withDuration: 0.3, animations: {
            
//            currentVC.alpha = 0
            
            destinationVC.alpha = 1.0
            destinationVC.transform = .identity
            
        },
        completion: { transitionContext.completeTransition($0) })
        
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.15
    }
}

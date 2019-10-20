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

//        destinationVC.alpha = 0.0
        
        let currentVCNumber = currentVC.value(forKeyPath: "tag") as! Int
        let destinationVCNumber = destinationVC.value(forKeyPath: "tag") as! Int
        
        let goingToTheRight = currentVCNumber - destinationVCNumber < 0 ? true : false
        
//        destinationVC.transform = .init(scaleX: 0.9, y: 0.9)
        
        destinationVC.transform = goingToTheRight ? .init(translationX: destinationVC.frame.size.width, y: 0) :
        .init(translationX: -destinationVC.frame.size.width, y: 0)
        
        transitionContext.containerView.addSubview(destinationVC)

        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
           
            currentVC.transform = goingToTheRight ? .init(translationX: -destinationVC.frame.size.width, y: 0) :
                                                    .init(translationX: destinationVC.frame.size.width, y: 0)
            
            destinationVC.transform = .identity
            
//            destinationVC.alpha = 1.0
            
        }) { (success) in
            
            currentVC.transform = .identity
            
            transitionContext.completeTransition(success)
        
        }
        
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.15
    }
}

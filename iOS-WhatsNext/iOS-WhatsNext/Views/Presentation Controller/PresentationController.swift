//
//  PresentationController.swift
//  iOS-WhatsNext
//
//  Created by Michael Willer on 25/07/2021.
//

import UIKit

/// Presents a view modally over a parent view with a blurred effect
class PresentationController: UIPresentationController {
    
    private let blurEffectView: UIVisualEffectView!
    private var tapGestureRecogniser: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, . flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecogniser)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect() }
        return CGRect(origin: CGPoint(x: 0,
                               y: containerView.frame.height * 0.4),
               size: CGSize(width: containerView.frame.width,
                            height: containerView.frame.height * 0.6))
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.alpha = 0.7
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.alpha = 0
        }, completion: { UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.roundCorners([.topLeft, .topRight], radius: 22)
    }
    
    override func containerViewDidLayoutSubviews() {
        guard let containerView = containerView else { return }
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView.bounds
    }
    
    /// Dismisses the modally presented view
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

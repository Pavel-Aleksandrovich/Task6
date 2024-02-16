//
//  ViewController.swift
//  Task6
//
//  Created by pavel mishanin on 16/2/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let rectangleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
        
        rectangleView.layer.cornerRadius = 10
        rectangleView.backgroundColor = .systemBlue
        rectangleView.center = view.center
        view.addSubview(rectangleView)
        
        let collision = UICollisionBehavior(items: [rectangleView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let behavior = UISnapBehavior(item: rectangleView, snapTo: rectangleView.center)
        behavior.damping = 0.5
        animator.addBehavior(behavior)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        
        if let behavior = animator.behaviors.first(where: { $0 is UISnapBehavior })   {
            animator.removeBehavior(behavior)
            
            let behavior = UISnapBehavior(item: rectangleView, snapTo: location)
            behavior.damping = 0.5
            animator.addBehavior(behavior)
        }
        
    }
}


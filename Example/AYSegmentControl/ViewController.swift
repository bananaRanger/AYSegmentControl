//
//  ViewController.swift
//  AYSegmentControl
//
//  Created by antonyereshchenko@gmail.com on 06/12/2019.
//  Copyright (c) 2019 antonyereshchenko@gmail.com. All rights reserved.
//

import UIKit
import AYSegmentControl

class ViewController: UIViewController {
  
  typealias Title = (name: String, image: String, color: UIColor)
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblImage: UILabel!
  
  @IBOutlet private weak var segmentControl: AYSegmentControl!
  
  let titles: [Title] = [("Account", "🥳", .purple),
                         ("Feed", "📰", .gray),
                         ("Settings", "🧰", .red)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentView.layer.cornerRadius = 16
    contentView.layer.addShadow()
    
    segmentControl.segmentTitles = titles.map { $0.name }
    segmentControl.isSelectionIndicatorHidden = false
    
    segmentControl.selectedTextColor = .darkText
    segmentControl.textColor = .lightGray
    segmentControl.lineColor = .purple
    
    segmentControl.lineHeight = 2
    segmentControl.lineCornerRadius = segmentControl.lineHeight / 2
    segmentControl.select(segment: 0, with: false)
    
    updateUI(with: segmentControl.selectedIndex)
  }
  
  @IBAction func segmentControlAction(_ sender: AYSegmentControl) {
    updateUI(with: sender.selectedIndex, animation: true)
  }
  
  private func updateUI(with index: Int, animation: Bool = false) {
    if animation { contentView.layer.runAnimation() }
    
    let title = titles[index]
    lblTitle.text = title.name
    lblImage.text = title.image
    segmentControl.lineColor = titles[index].color
  }
}

//MARK: - CALayer extension
fileprivate extension CALayer {
  func addShadow() {
    shadowRadius = 16
    shadowOpacity = 0.1
  }
  
  func runAnimation() {
    
    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 0.2
    animationGroup.autoreverses = true
    
    let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
    shadowAnimation.fromValue = shadowOpacity
    shadowAnimation.toValue = 0
    
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.fromValue = 1.0
    scaleAnimation.toValue = 0.95
    
    animationGroup.animations = [shadowAnimation, scaleAnimation]
    
    add(animationGroup, forKey: nil)
  }
}


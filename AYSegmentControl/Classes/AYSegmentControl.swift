// MIT License
//
// Copyright (c) 2019 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

// MARK: - AYSegmentControl class -
public class AYSegmentControl: UIControl, AYSegment {
  
  // MARK: - Private properties
  private var configurator = AYSegmentItemConfigurator()
  
  private var lineLayer: AYSegmentItemLineLayer?
  
  // MARK: - Public properties
  public var isSelectionIndicatorHidden = false {
    didSet {
      if isSelectionIndicatorHidden {
        lineLayer?.removeFromSuperlayer()
        lineLayer = nil
      } else {
        guard lineLayer == nil else { return }
        let layer = AYSegmentItemLineLayer()
        layer.cornerRadius = lineCornerRadius
        layer.backgroundColor = lineColor.cgColor
        self.layer.addSublayer(layer)
        lineLayer = layer
        layoutSubviews()
      }
    }
  }
  
  public var spacing = CGFloat(0.0)
  
  public var lineHeight = CGFloat(8.0) {
    didSet {
      if let segment = subLabel(byTag: selectedIndex ?? 0) {
        lineLayer?.frame = AYSegmentItemLineLayer.lineRect(with: segment.frame, and: lineHeight)
        lineLayer?.isHidden = selectedIndex == nil
      }
    }
  }
  
  public var lineCornerRadius = CGFloat(0.0) {
    didSet {
      lineLayer?.cornerRadius = lineCornerRadius
    }
  }
  
  public var lineColor: UIColor = UIColor.black {
    didSet {
      lineLayer?.backgroundColor = lineColor.cgColor
    }
  }
  
  public var textColor: UIColor {
    get {
      return configurator.textColor
    }
    set {
      configurator.textColor = newValue
    }
  }
  
  public var itemsColor: UIColor {
    get {
      return configurator.itemsColor
    }
    set {
      configurator.itemsColor = newValue
    }
  }
  
  public var font: UIFont {
    get {
      return configurator.font
    }
    set {
      configurator.font = newValue
    }
  }
  
  public var selectedTextColor: UIColor {
    get {
      return configurator.selectedTextColor
    }
    set {
      configurator.selectedTextColor = newValue
    }
  }
  
  public var selectedItemsColor: UIColor {
    get {
      return configurator.selectedItemsColor
    }
    set {
      configurator.selectedItemsColor = newValue
    }
  }
  
  public var segmentTitles = [String]() {
    didSet {
      subviews.forEach { $0.removeFromSuperview() }
      let items = configurator.createItems(with: segmentTitles)
      configurator.update(item: items.first, with: .selected)
      reload(with: items)
    }
  }
  
  public private(set) var selectedIndex: Int? = nil {
    didSet {
      guard let index = selectedIndex else { return }
      self.selectedIndex = index >= 0 ? index : 0
      self.selectedIndex = index >= subviews.count ? subviews.count - 1 : index
    }
  }
  
  // MARK: - Overridden methods
  override public func layoutSubviews() {
    super.layoutSubviews()
    guard let index = selectedIndex else { return }
 
    if let segment = subLabel(byTag: index) {
      if let layer = lineLayer {
        layer.frame = AYSegmentItemLineLayer.lineRect(with: segment.frame, and: lineHeight)
      }
    }
    
    guard let selected = subLabel(byTag: index) else { return }
    lineLayer?.update(with: selected.frame, with: false)
  }
  
  override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.beginTracking(touch, with: event)
    let point = touch.location(in: self)

    guard let detectedSegment = detectSubview(point) else { return false }
    
    guard let index = selectedIndex else {
      reset(to: detectedSegment.tag)
      lineLayer?.isHidden = false
      lineLayer?.update(with: detectedSegment.frame, with: false)
      return false
    }
    
    guard let currentSegment = subLabel(byTag: index),
      detectedSegment.tag != currentSegment.tag else { return true }
    
    configurator.update(item: currentSegment, with: .normal)
    configurator.update(item: detectedSegment, with: .selected)
    
    return true
  }
  
  override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.continueTracking(touch, with: event)
    let point = touch.location(in: self)
    
    guard let index = selectedIndex else { return false }

    guard let detectedSegment = detectSubview(point, ignoringY: true),
      let currentSegment = subLabel(byTag: index) else { return true }
    
    configurator.update(item: currentSegment, with: .normal)
    configurator.update(item: detectedSegment, with: .selected)
    
    let rect = rectForMove(view: detectedSegment, with: point)
    
    lineLayer?.update(with: rect, with: false)
    selectedIndex = detectedSegment.tag != currentSegment.tag ?
      detectedSegment.tag : selectedIndex
    
    return true
  }
  
  override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    guard let point = touch?.location(in: self) else { return }

    guard let index = selectedIndex else { return }

    guard let detectedSegment = detectSubview(point),
      let currentSegment = subLabel(byTag: index),
      detectedSegment.tag != currentSegment.tag else {
        if let currentSegment = subLabel(byTag: index) {
          lineLayer?.update(with: currentSegment.frame, with: false)
        }
        return
    }
    
    lineLayer?.update(with: detectedSegment.frame, with: false)
    selectedIndex = detectedSegment.tag
  }
  
  // MARK: - Public methods
  public func select(segment index: Int, with animation: Bool) {
    reset()

    lineLayer?.isHidden = false
  
    guard let nextSegment = subLabel(byTag: index),
      let currentSegment = subLabel(byTag: selectedIndex ?? 0) else { return }
  
    configurator.update(item: currentSegment, with: .normal)
    configurator.update(item: nextSegment, with: .selected)
    
    lineLayer?.update(with: nextSegment.frame, with: animation)
    selectedIndex = nextSegment.tag
  }
  
  public func unselect() {
    let fromIndex = 0
    let toIndex = segmentTitles.count
    (fromIndex..<toIndex).forEach {
      configurator.update(item: subLabel(byTag: $0), with: .normal)
    }
  }
  
  // MARK: - Private methods
  func reset(to index: Int = 0) {
    let fromIndex = 0
    let toIndex = segmentTitles.count
    (fromIndex..<toIndex).forEach {
      let label = subLabel(byTag: $0)
      configurator.update(item: label, with: $0 == index ? .selected : .normal)
    }
    selectedIndex = index
  }
  
  private func reload(with labels: [UILabel]) {
    guard let first = labels.first, let last = labels.last else { return }
    first.addFirstSegmentSubview(on: self)
    last.addLastSegmentSubview(on: self)
    
    (labels.index(after: first.tag)...last.tag).forEach { index in
      let current = labels[index]
      let previous = labels[index - 1]
      current.addSegmentSubview(on: self, with: previous, spacing: spacing)
      current.addEqualWidthAnchor(with: previous)
    }
  }
  
}

// MARK: - UIView subviews extensions
extension UIView {
  func detectSubview(_ point: CGPoint, ignoringX: Bool = false, ignoringY: Bool = false) -> UILabel? {
    return subviews.first(where: {
      guard $0 is UILabel else { return false }
      let point = CGPoint(x: ignoringX ? 0 : point.x, y: ignoringY ? 0 : point.y)
      return $0.point(inside: $0.convert(point, from: $0.superview), with: nil)
    }) as? UILabel
  }
  
  func subLabel(byTag: Int) -> UILabel? {
    return subviews.first(where: { $0.tag == byTag }) as? UILabel
  }
  
  func addSubview(segment: UIView) {
    if segment.superview == nil {
      addSubview(segment)
    }
  }
}

// MARK: - Fileprivate extensions

// MARK: - UIView movement extensions
fileprivate extension UIView {
  func rectForMove(view: UIView, with point: CGPoint) -> CGRect {
    let width = bounds.width
    let segmentWidth = view.bounds.width
    let leftLinePoint = point.x - segmentWidth / 2
    let rightLinePoint = point.x + segmentWidth / 2
    
    var x: CGFloat = 0.0
    x = rightLinePoint > width ? width - segmentWidth : leftLinePoint
    x = x >= 0 ? x : 0
    
    return CGRect(origin: CGPoint(x: x, y: view.bounds.origin.y), size: view.bounds.size)
  }
}

// MARK: - UIView positioning extensions
fileprivate extension UIView {
  func addFirstSegmentSubview(on superview: UIView, spacing: CGFloat = 0.0) {
    superview.addSubview(segment: self)
    translatesAutoresizingMaskIntoConstraints = false
    leftAnchor.constraint(equalTo: superview.leftAnchor, constant: spacing).isActive = true
    topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
  }
  
  func addLastSegmentSubview(on view: UIView) {
    view.addSubview(segment: self)
    translatesAutoresizingMaskIntoConstraints = false
    rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
  }
  
  func addSegmentSubview(on superview: UIView, with view: UIView, spacing: CGFloat = 0.0) {
    superview.addSubview(segment: self)
    translatesAutoresizingMaskIntoConstraints = false
    leftAnchor.constraint(equalTo: view.rightAnchor, constant: spacing).isActive = true
    topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
  }
  
  func addEqualWidthAnchor(with view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
  }
}

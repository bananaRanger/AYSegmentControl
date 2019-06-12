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

// MARK: - AYSegmentItemLineLayer class
class AYSegmentItemLineLayer: CALayer {
  private var animationDuration = 0.12
  private var isAnimationStart = false
  
  func update(with rect: CGRect, with animation: Bool) {
    if !isAnimationStart  {
      isAnimationStart = animation
      let pathAnimation = CABasicAnimation(keyPath: "frame.origin.x")
      pathAnimation.fromValue = frame.origin.x
      pathAnimation.toValue = rect.origin.x
      pathAnimation.duration = animationDuration
      pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      pathAnimation.delegate = self
      add(pathAnimation, forKey: nil)
      frame.origin.x = rect.origin.x
    }
  }
}

// MARK: - AYSegmentItemLineLayer extensions
extension AYSegmentItemLineLayer: CAAnimationDelegate {
  public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    isAnimationStart = false
  }
}

extension AYSegmentItemLineLayer {
  static func lineRect(with controlRect: CGRect, and lineHeight: CGFloat) -> CGRect {
    let origin = CGPoint(x: 0, y: controlRect.height - lineHeight)
    let size = CGSize(width: controlRect.width, height: lineHeight)
    let rect = CGRect(origin: origin, size: size)
    return rect
  }
}

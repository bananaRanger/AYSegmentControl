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

// MARK: - AYSegment protocol 
public protocol AYSegment where Self: UIControl {
  var spacing: CGFloat { get set }
  
  var lineHeight: CGFloat { get set }
  var lineCornerRadius: CGFloat { get set }
  var lineColor: UIColor { get set }
  
  var textColor: UIColor { get set }
  var itemsColor: UIColor { get set }
  
  var font: UIFont { get set }
  
  var selectedTextColor: UIColor { get set }
  var selectedItemsColor: UIColor { get set }
  
  var segmentTitles: [String] { get set }
  
  var selectedIndex: Int? { get }
  
  func unselect()
  func select(segment index: Int, with animation: Bool)
}

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

// MARK: - AYSegmentItemConfigurator class
class AYSegmentItemConfigurator {
  enum AYSegmentItemState: Int {
    case normal
    case selected
  }
  
  var textColor = UIColor.black
  
  var itemsColor = UIColor.clear
  
  var font = UIFont.systemFont(ofSize: 14)
  
  var selectedTextColor = UIColor.black
  
  var selectedItemsColor = UIColor.clear
  
  func createItems(with titles: [String]) -> [UILabel] {
    var tag = 0
    return titles.map { string -> UILabel in
      defer { tag += 1 }
      return createItem(with: string, and: tag)
    }
  }
  
  func createItem(with title: String, and tag: Int) -> UILabel {
    let label = UILabel()
    label.font = font
    label.backgroundColor = itemsColor
    label.textColor = textColor
    label.text = title
    label.tag = tag
    label.textAlignment = .center
    return label
  }
  
  func update(item: UILabel?, with state: AYSegmentItemState) {
    item?.backgroundColor = state == .selected ? selectedItemsColor : itemsColor
    item?.textColor = state == .selected ? selectedTextColor : textColor
    item?.font = font
  }
}

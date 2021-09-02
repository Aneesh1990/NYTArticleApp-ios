//
//  NSObject+Extentions.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}

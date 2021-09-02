//
//  AppStoryboards.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case main          = "Main"
}
protocol StoryboardViewController {
    static func instantiate(from storyboard: AppStoryboard) -> Self
}
extension StoryboardViewController where Self: UIViewController {
    static func instantiate(from storyboard: AppStoryboard) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

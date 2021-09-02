//
//  BaseViewController.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation

import UIKit

class BaseViewController:UIViewController,StoryboardViewController {}
extension BaseViewController:ErrorHandle{
    func showError(error: String) {
        self.showAlert(title: "error", message: error)
    }
}

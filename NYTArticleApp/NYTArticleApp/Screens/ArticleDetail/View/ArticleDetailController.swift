//
//  ArticleDetailController.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation
import UIKit

class ArticleDetailController: BaseViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var articleImage:   UIImageView!
    @IBOutlet weak var byLabel:        UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var content:        UILabel!
    //MARK:- Let & Var
    var article:ArticleCellViewModel?
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArticleData(article: article)
    }
    func setupArticleData(article:ArticleCellViewModel?){
        if let articleDetails = article {
            content.text         = articleDetails.heading
            byLabel.text         = articleDetails.userName
            publishedLabel.text  = articleDetails.createdAt
            articleImage?.loadImageUsingCache(withUrl: article?.detailImageURL ?? "")
        }
    }
}

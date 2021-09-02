//
//  ArticleViewModel.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation

protocol ErrorHandle {
    func showError(error:String)
}
class ArticleViewModel: NSObject {
    
    //MARK:- Let & Var
    var reloadTableView: (() -> Void)?
    var articles = Articles()
    var delegate:ErrorHandle!
    private var articleService: ArticlesServiceProtocol
    var articleCellViewModels = [ArticleCellViewModel]() {
        didSet {reloadTableView?()}
    }
    
    //MARK:-initialize
    init(articleService: ArticlesServiceProtocol = ArticlesService()) {
        self.articleService = articleService
    }
    
    //MARK:- Get Articles API
    func getArticles(period: Periods) {
        articleService.getArticles(period: period){ [weak self] success, model, error in
            if success, let articles = model {
                self?.fetchData(articles: articles)
            } else {
                guard let errorResponse = error else { return }
                self?.delegate?.showError(error: errorResponse)
            }
        }
    }
    //MARK:- Get Cell Models
    func getCellViewModel(at indexPath: IndexPath) -> ArticleCellViewModel {
        return articleCellViewModels[indexPath.row]
    }
    
    //MARK:- fileprivate Methods
   fileprivate func fetchData(articles: Articles) {
        self.articles = articles // Cache
        var cellViewModels = [ArticleCellViewModel]()
        for article in articles {
            cellViewModels.append(createCellModel(article: article))
        }
        articleCellViewModels = cellViewModels
    }
    fileprivate func createCellModel(article: Article) -> ArticleCellViewModel {
        let heading = article.title ?? ""
        let name = article.byline  ?? ""
        let date = article.published_date ?? ""
        let image = article.media?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.first?.url:"":""
        let detailImage = article.media?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.last?.url:"":""
        return ArticleCellViewModel(heading: heading, userName: name, createdAt: date, imageURL: image ?? "",detailImageURL: detailImage ?? "")
    }
}

//
//  ArticlesService.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation

protocol ArticlesServiceProtocol {
    func getArticles(period:Periods,completion: @escaping (_ success: Bool, _ results: Articles?, _ error: String?) -> ())
}

class ArticlesService: ArticlesServiceProtocol {
    func getArticles(period:Periods,completion: @escaping (Bool, Articles?, String?) -> ()) {
        HttpRequestHelper().request(url: Constant.API.baseURL + Constant.Endpoint.mostpopular + "\(period.rawValue).json",method:.GET,params: ["api-key": Constant.API.apiKey], httpHeader: .application_json) { result in
            switch result {
            case .failure(let error):
                completion(false, nil, error.localizedDescription)
            case .success(let data):
                    do {
                        let model = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                        completion(true, model.articles, nil)
                    } catch {
                        completion(false, nil, Constant.ErrorMessage.parseError)
                    }
                }
        }
    }
}

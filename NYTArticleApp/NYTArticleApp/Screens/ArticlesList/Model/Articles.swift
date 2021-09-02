//
//  Articles.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation

typealias Articles = [Article]

// MARK: - Employee
struct ArticlesResponse : Codable {
    let status      : String?
    let copyright   : String?
    let num_results : Int?
    let articles    : [Article]?
    
    enum CodingKeys: String, CodingKey {
        
        case status      = "status"
        case copyright   = "copyright"
        case num_results = "num_results"
        case articles    = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        status      = try values.decodeIfPresent(String.self, forKey: .status)
        copyright   = try values.decodeIfPresent(String.self, forKey: .copyright)
        num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        articles    = try values.decodeIfPresent([Article].self, forKey: .articles)
    }
    
}

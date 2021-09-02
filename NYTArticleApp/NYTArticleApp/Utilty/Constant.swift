//
//  Constant.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation

struct Constant {
    struct API {
        static let baseURL     = "https://api.nytimes.com/"
        static let apiKey      = "HOUaXCaDBpIMkYEFg9cmnBOxuK26hDBF"
    }
    struct Endpoint {
        static let mostpopular = "svc/mostpopular/v2/viewed/"
    }
    struct ErrorMessage {
        static let unknown     = "Error: Something went wrong"
        static let parseError  = "Error: Trying to parse Articles to model"
    }
}

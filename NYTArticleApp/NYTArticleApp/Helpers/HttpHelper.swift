//
//  HttpHelper.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation
class HttpRequestHelper {
    func request(url: String,method:HTTPMethods,params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Result<Data, Error>) -> ()) {
        AGActivityIndicator.show()
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        /* .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)*/
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                complete(.failure(error))
            }
            AGActivityIndicator.dismiss()
            guard let responseData = data, error == nil else {
                complete(.failure(error ?? NetworkRequestError.unknown(data, response)))
                return
            }
            complete(.success(responseData))
        }.resume()
    }
}

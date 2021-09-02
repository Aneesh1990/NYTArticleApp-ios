//
//  HTTPEnums.swift
//  NYTArticleApp
//
//  Created by Aneesh on 02/09/2021.
//

import Foundation

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}
enum HTTPMethods:String {
    case GET
    case POST
    case UPDATE
    case PATCH
    case DELETE
}
public enum Result<T, U> {
    case success(T)
    case failure(U)
}
enum ApiResultCode {
    case invalidData
    case recordNotFound
    case unknown(String)
}
enum NetworkRequestError: Error {
    case api(_ status: Int, _ code: ApiResultCode, _ description: String)
    case unknown(Data?, URLResponse?)
}
extension ApiResultCode {
    static func code(for string: String) -> ApiResultCode {
        switch string {
        case "invalid_data":   return .invalidData
        case "record_not_found": return .recordNotFound
        default:                 return .unknown(string)
        }
    }
}


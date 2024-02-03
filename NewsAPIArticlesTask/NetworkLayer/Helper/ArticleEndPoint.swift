//
//  ArticleEndPoint.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import Foundation

typealias StringArr = [String: String]

enum ArticleEndPoint {
  case articleFetch(queryParams: StringArr?)
}

extension ArticleEndPoint: EndPoint {

    var host: String {
        "newsapi.org"
    }

    var path: String {
        "/v2/top-headlines"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var header: StringArr? {
        return ["Content-Type": "application/json"]
    }
    
    var body: StringArr? {
        return nil
    }
    
    var queryParams: StringArr? {
        switch self {
        case .articleFetch(queryParams: let queryParams):
            return queryParams
        }
    }
    
    var pathParams: StringArr? {
        switch self {
        case .articleFetch(queryParams: let queryParams):
            return queryParams
        }
    }
}

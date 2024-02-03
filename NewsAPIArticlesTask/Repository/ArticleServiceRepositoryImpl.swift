//
//  ArticleServiceRepositoryImpl.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import Foundation

final class ArticleServiceRepositoryImpl: ArticleServiceRepository {
    private var networkService: Networkable
    
    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchArticles() async throws -> Articles {
        let queryParams: StringArr = Constants.queryParamFetch
        let articleData = try await networkService.sendRequest(endpoint: ArticleEndPoint.articleFetch(queryParams: queryParams)) as ArticleData
        guard articleData.articles.isNotEmpty else {
            throw NetworkError.decode
        }
        return articleData.articles
    }
}

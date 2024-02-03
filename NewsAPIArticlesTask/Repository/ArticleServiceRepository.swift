//
//  ArticleServiceRepository.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import Foundation

protocol ArticleServiceRepository {
    func fetchArticles() async throws -> Articles
}

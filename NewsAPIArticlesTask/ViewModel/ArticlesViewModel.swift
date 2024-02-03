//
//  ArticlesViewModel.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import Foundation

@MainActor
final class ArticlesViewModel: ObservableObject {
    @Published var articles: Articles = Articles()
    @Published var error: NetworkError?
    var errorMessage: String {
        error?.customMessage ?? ""
    }
    private var articleService: ArticleServiceRepository
    init(articleService: ArticleServiceRepository = ArticleServiceRepositoryImpl()) {
        self.articleService = articleService
        Task(priority: .background, operation: {
            await fetchArticles()
        })
    }
}

extension ArticlesViewModel {
    func fetchArticles() async {
        do {
            let articleData = try await articleService.fetchArticles()
            articles = articleData.sorted {
                $0.articleAuthor < $1.articleAuthor
            }
        } catch {
            self.error = error as? NetworkError
        }
    }
}

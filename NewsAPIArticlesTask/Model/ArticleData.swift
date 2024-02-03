//
//  ArticleData.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import Foundation

// MARK: - ArticleData
struct ArticleData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    private enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    var articleAuthor: String {
        return author ?? ""
    }
    var articleImage: String {
        return urlToImage ?? Constants.dummyImage
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

typealias Articles = [Article]

extension Article {
    static func dummyArticle() -> Article {
        return Article(
            source: Source(
                id: "axios",
                name: "Axios"
            ),
            author: "Axios",
            title: "Paypal is the latest tech company to announce layoffs - Axios",
            description: "",
            url: "https://www.axios.com/2024/01/30/paypal-layoffs-2024-tech",
            urlToImage: "https://deadline.com/wp-content/uploads/2018/11/byron_allen-2018-4-e1595250386875.jpg?w=1024",
            publishedAt: "2024-01-31T04:00:00Z",
            content: "Move over, David Ellison, because here comes Byron Allen. \r\nThe media mogul and owner of The Weather Channel has made a $30 billion offer for the debt and equity of Paramount Global, Deadline has con…"
        )
    }
}
extension ArticleData {
    static func dummyArticleData() -> ArticleData {
        return ArticleData(
            status: "ok",
            totalResults: 1,
            articles: [Article(
                source: Source(
                    id: "axios",
                    name: "Axios"
                ),
                author: "Axios",
                title: "Paypal is the latest tech company to announce layoffs - Axios",
                description: "",
                url: "https://www.axios.com/2024/01/30/paypal-layoffs-2024-tech",
                urlToImage: "https://deadline.com/wp-content/uploads/2018/11/byron_allen-2018-4-e1595250386875.jpg?w=1024",
                publishedAt: "2024-01-31T04:00:00Z",
                content: "Move over, David Ellison, because here comes Byron Allen. \r\nThe media mogul and owner of The Weather Channel has made a $30 billion offer for the debt and equity of Paramount Global, Deadline has con…"
            )]
        )

    }
}

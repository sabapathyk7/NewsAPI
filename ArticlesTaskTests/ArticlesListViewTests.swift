//
//  ArticlesListViewTests.swift
//  ArticlesListViewTests
//
//  Created by kanagasabapathy on 01/02/24.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NewsAPIArticlesTask

final class ArticlesListViewTests: XCTestCase {
    @MainActor func test_content_for_tests() async throws {
        let viewModel = ArticlesViewModel(articleService: ArticleServiceRepositoryImpl(networkService: MockServiceable()))
        await viewModel.fetchArticles()
        let sut = ArticleListView(viewModel: viewModel)
        XCTAssertNoThrow(try sut.inspect().allowsHitTesting())
    }

    @MainActor func test_content_for_build() async throws {
        let viewModel = ArticlesViewModel(articleService: ArticleServiceRepositoryImpl(networkService: MockServiceable()))
        await viewModel.fetchArticles()
        let sut = ArticleListView(viewModel: viewModel)
        XCTAssertNoThrow(try sut.inspect().view(ArticleListView.self, 0))
    }
}

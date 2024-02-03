//
//  ViewModelTests.swift
//  ArticlesTaskTests
//
//  Created by kanagasabapathy on 01/02/24.
//

import XCTest
@testable import NewsAPIArticlesTask

final class ViewModelTests: XCTestCase {
    // assigning ViewModel to variable sut
    var sut: ArticlesViewModel!

    // MainActor = Dispatch.main.async - helps in loading UI
    // Testing Life Cycle method: setting up
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ArticlesViewModel(articleService: ArticleServiceRepositoryImpl(networkService: MockServiceable()))
    }
    // MainActor = Dispatch.main.async - helps in loading UI
    // Testing Life Cycle method: tearing down
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    // Testing the fetch Articles with test data
    func testFetchArticlesAsync() async {
        var articles = await sut.articles
        await sut.fetchArticles()
        articles = await sut.articles
        XCTAssertGreaterThan(articles.count, 0, "")
        XCTAssertEqual(articles.first?.title, "Paypal is the latest tech company to announce layoffs - Axios")
    }
    // Testing the fetch Articles with test data - Failure cases
    func testFetchArticlesFailed() async {
        var articles = await sut.articles
        await sut.fetchArticles()
        articles = await sut.articles
        XCTExpectFailure("This is the failure block") {
            XCTAssertGreaterThan(articles.count, 1, "")
            XCTAssertEqual(articles.first?.title, "PayBall")
        }
    }
    // Testing the fetch Articles with test data
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            Task(priority: .background, operation:  {
                await sut.fetchArticles()
            })
        }
    }
}

final class MockServiceable: Networkable {
    func sendRequest<T>(endpoint: NewsAPIArticlesTask.EndPoint) async throws -> T where T : Decodable {
        let articleData = ArticleData.dummyArticleData()
        guard let article = articleData as? T else {
            fatalError("Not articleData we are expecting")
        }
        return article
    }
}

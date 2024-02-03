//
//  ArticleDetailViewTests.swift
//  ArticlesTaskTests
//
//  Created by kanagasabapathy on 01/02/24.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NewsAPIArticlesTask

final class ArticleDetailViewTests: XCTestCase {
    func test_content_for_tests() {
        let sut = ArticleDetailView(article: .constant(Article.dummyArticle()))
        XCTAssertNoThrow(try sut.inspect().allowsHitTesting())
    }

    func test_content_for_build() {
        let sut = ArticleDetailView(article: .constant(Article.dummyArticle()))
        XCTAssertNoThrow(try sut.inspect().view(ArticleDetailView.self, 0))
    }
}

final class ArticleDetailDescViewTests: XCTestCase {
    func test_content_for_tests() {
        let sut = ArticleDetailDescView(article: Article.dummyArticle())
        XCTAssertNoThrow(try sut.inspect().allowsHitTesting())
    }

    func test_content_for_build() {
        let sut = ArticleDetailDescView(article: Article.dummyArticle())
        XCTAssertNoThrow(try sut.inspect().view(ArticleDetailDescView.self, 0))
    }
}
final class SettingsViewTests: XCTestCase {
    func test_content_for_tests() {
        let themeManager = ThemeManager()
        let sut = SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(false), themeManager: themeManager)
        XCTAssertNoThrow(try sut.inspect().allowsHitTesting())
    }

    func test_content_for_build() {
        let themeManager = ThemeManager()
        let sut = SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(false), themeManager: themeManager)
        XCTAssertNoThrow(try sut.inspect().view(SettingsView.self, 0))
    }
}

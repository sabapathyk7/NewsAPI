//
//  ViewPreviewsTests.swift
//  ArticlesTaskTests
//
//  Created by kanagasabapathy on 02/02/24.
//

import XCTest
import ViewInspector
@testable import NewsAPIArticlesTask

final class ViewPreviewsTests: XCTestCase {

    func test_contentView_previews() {
        _ = ContentView_Previews.previews
    }
    func test_articleListView_previews() {
        _ = ArticleListView_Previews.previews
    }
    func test_articleDetailView_previews() {
        _ = ArticleDetailView_Previews.previews
    }
    func test_articleDetailDescView_previews() {
        _ = ArticleDetailDescView_Previews.previews
    }
    func test_safariView_previews() {
        _ = SafariView_Previews.previews
    }
    func test_settingsView_previews() {
        _ = SettingsView_Previews.previews
    }
    func test_cacheAsyncImage_previews() {
        _ = CacheAsyncImage_Previews.previews
    }
}

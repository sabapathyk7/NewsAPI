//
//  Constants.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import Combine
import Foundation
import SwiftUI

extension Collection {
    var isEmpty: Bool { startIndex == endIndex }
    var isNotEmpty: Bool { !isEmpty }
}

enum Constants {
    static let queryParamFetch  = ["country": "us", "category": "business", "apiKey": "7798387c3293416d8928c7663997d6c3"]
    static let dummyImage       = "https://i.stack.imgur.com/2R7tR.png"
    static let description      = "Description"
    static let showLess         = "Show Less  -"
    static let showMore         = "Show More  +"
    static let newsArticles     = "News Articles"
}

enum Theme {
    static let textColor = Color("TextColor")
}

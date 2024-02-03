//
//  ArticleDetailDescView.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import SwiftUI

struct ArticleDetailDescView: View {
    @State private var isViewed = false
    var article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title).font(.title)
            Text(Constants.description).font(.title2)
                .padding(10)
            Text(article.description ?? "")
                .font(.caption)
                .padding(10)
                .multilineTextAlignment(.leading)
                .lineLimit(isViewed ? 10 : 1)
            Button(isViewed ? Constants.showLess : Constants.showMore) {
                isViewed.toggle()
            }
            .font(.subheadline)
            .foregroundStyle(Theme.textColor)
            .padding(10)
        }
        .padding(10)
    }
}

#if DEBUG
struct ArticleDetailDescView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailDescView(article: Article.dummyArticle())
    }
}
#endif

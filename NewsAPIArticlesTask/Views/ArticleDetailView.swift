//
//  ArticleDetailView.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import SwiftUI

struct ArticleDetailView: View {
    @Binding var article: Article
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        AsyncImage(url: URL(string: article.articleImage)) { image in
                            image.resizable()
                                .frame(width: 180, height: 180)
                                .aspectRatio(0.5, contentMode: .fit)
                                .clipShape(Rectangle())
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .background(Color(red: 232/255.0, green: 241/255.0, blue: 238/255.0))
                    Spacer()
                    ArticleDetailDescView(article: article)
                }
            }
            .navigationTitle(article.articleAuthor)
        }
    }
}

#if DEBUG
struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: .constant(Article.dummyArticle()))
    }
}
#endif

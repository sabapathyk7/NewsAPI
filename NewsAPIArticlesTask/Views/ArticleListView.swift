//
//  ArticleListView.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import SwiftUI

struct ArticleListView: View {

    @ObservedObject var viewModel: ArticlesViewModel

    let columns = [GridItem(.flexible())]

    @State private var showErrorAlert = false
    @State private var showSafariView = false

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                loadView()
                .navigationTitle(Constants.newsArticles)
            }
            .alert(isPresented: $showErrorAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
            .onChange(of: viewModel.error) { error in
                // Trigger alert presentation when an error occurs
                showErrorAlert = error != nil
            }
            .refreshable {
                // Enable Pull to refresh
                await viewModel.fetchArticles()
            }
        } else {
            NavigationView {
                loadView()
                .navigationTitle(Constants.newsArticles)
            }
            .alert(isPresented: $showErrorAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
            .onChange(of: viewModel.error) { error in
                // Trigger alert presentation when an error occurs
                showErrorAlert = error != nil
            }
            .refreshable {
                // Enable Pull to refresh
                await viewModel.fetchArticles()
            }
        }
    }
    private func loadView() -> some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach($viewModel.articles) { $article in
                    if (article.author != nil) {
                        NavigationLink {
                            ArticleDetailView(article: $article)
                        } label: {
                            ArticleListViewItem(article: article)
                                .onTapGesture {
                                    showSafariView = true
                                }
                                .sheet(isPresented: $showSafariView) {
                                    if let stringUrl = article.url,
                                       let url = URL(string: stringUrl) {
                                        SafariView(url: url)
                                    }
                                }
                        }
                    }
                }
            })
        }
    }
}

struct ArticleListViewItem: View {
    @State var article: Article
    private let imageWidth = 150.0
    private let imageHeight = 150.0
    private let cellHeight = 150.0
    var body: some View {
        HStack {
            CacheAsyncImage(
                url: URL(string: article.articleImage)!
            ) { phase in
                switch phase {
                case .success(let image):
                    HStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageWidth, height: imageHeight)
                            .padding([.leading, .trailing], 10)
                        Spacer()
                    }
                case .failure(let error):
                    Text(error.localizedDescription)
                case .empty:
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        Spacer()
                    }
                @unknown default:
                    Image(systemName: "questionmark")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: cellHeight)
            .padding()
            .listRowSeparator(.hidden)

            VStack(alignment: .leading) {
                Text(article.title)
                    .foregroundColor(Theme.textColor)
                    .font(.system(size: 18, weight: .semibold))
                Text(article.source.name)
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
                HStack(spacing: 4) {
                    Text(article.publishedAt)
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .bold))
                }
            }
        }
        .padding()
        .foregroundStyle(Theme.textColor)
    }
}

#if DEBUG
struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(viewModel: ArticlesViewModel())
    }
}
#endif

//
//  ContentView.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("systemThemeEnabled") private var systemThemeEnabled = false
    
    private let themeManager = ThemeManager()
    
    @StateObject private var viewModel: ArticlesViewModel = ArticlesViewModel()
    @State private var showErrorAlert = false
    
    var body: some View {
        TabView {
            ArticleListView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Articles")
                }
            SettingsView(darkModeEnabled: $darkModeEnabled,
                         systemThemeEnabled: $systemThemeEnabled,
                         themeManager: themeManager)
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
        .onAppear {
            self.themeManager.handleTheme(darkMode: darkModeEnabled,
                                          system: systemThemeEnabled)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

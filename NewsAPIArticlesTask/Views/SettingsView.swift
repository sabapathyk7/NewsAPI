//
//  SettingsView.swift
//  NewsAPIArticlesTask
//
//  Created by kanagasabapathy on 01/02/24.
//

import SwiftUI

struct SettingsView: View {

    @Binding var darkModeEnabled: Bool
    @Binding var systemThemeEnabled: Bool
    
    let themeManager: ThemeManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Display"),
                        footer: Text("System settings will override Dark Mode and use the current device theme")) {
                    Toggle(isOn: $darkModeEnabled,
                           label: {
                        Text("Dark mode")
                    })
                    .onChange(of: darkModeEnabled,
                              perform: { _ in
                        themeManager.handleTheme(darkMode: darkModeEnabled,
                                                 system: systemThemeEnabled)

                    })
                    Toggle(isOn: $systemThemeEnabled,
                           label: {
                        Text("Use system settings")
                    })
                    .onChange(of: systemThemeEnabled,
                              perform: { _ in
                        themeManager.handleTheme(darkMode: darkModeEnabled,
                                                 system: systemThemeEnabled)

                    })
                }
                        .foregroundColor(Theme.textColor)
                        .font(.system(size: 16, weight: .semibold))
            }
            .navigationTitle("Settings")
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(false), themeManager: ThemeManager())
    }
}
#endif

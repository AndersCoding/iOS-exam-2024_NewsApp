

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        VStack{
            NewsTicker() // Newsticker animation that works on all the other screens in the tabview
        
            // Tabview with four (4) screens available for user
        TabView {
            ArticlesView() // Display stored articles
                .tabItem{
                    Label("Articles", systemImage: "newspaper")
                }
            SearchView() // Screen for user to search articles
                .tabItem{
                    Label("Search NewsAPI", systemImage: "magnifyingglass.circle.fill")
                }
            TopHeadlinesView() // Screen for user to search top headlines country, category and number of shown articles. NOTE! Only "us" works.
                .tabItem{
                    Label("Categories", systemImage: "books.vertical.circle")
                }
            SettingsView() // Settings screen for user to modify application experience
                .tabItem{
                    Label("Settings", systemImage: "gearshape")
                }
            
        }
        }
        .navigationBarBackButtonHidden(true) // Remove the posibility to go back to splashscreen
    }

}

#Preview {
    ContentView()
}

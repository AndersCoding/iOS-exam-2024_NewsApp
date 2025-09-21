import SwiftUI
import SwiftData
// Main file for the application
// Takes in FavouriteArticle for stored articles
@main
struct NewsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([FavouriteArticle.self])  //Schema for FavouriteArticle
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)  // Persistent storage
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SplashView() // SplashScreen, with owl-animation, the first screen to be shown, to later guide the user to the homepage ContentView
                    .modelContainer(sharedModelContainer)
            }
        }
    }
}


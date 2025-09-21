import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []  // List of articles to display
    @Published var isLoading: Bool = false   // Loading boolean, for when loading
    @Published var searchQuery: String = ""  // Search query from the user
    @Published var sortBy: String = "publishedAt" // Default sorting by publishedAt, newest articles displayed first

    // Fetch articles based on the search query from the user
    func fetchArticles() {
            Task {
                do {
                    // Main thread async
                    DispatchQueue.main.async {
                        self.isLoading = true
                    }
                    
                    let articles = try await NewsAPIService.shared.fetchArticles(searchQuery: searchQuery, sortBy: sortBy)
                    
                    // Update the main thread after the async
                    DispatchQueue.main.async {
                        self.articles = articles
                        self.isLoading = false
                    }
                } catch {
                    print("Error fetching articles: \(error.localizedDescription)")
                    
                    // Update the main thread in case of an error
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }
    // Update search query and fetch articles
    func updateSearchQuery(_ query: String) {
        self.searchQuery = query
        fetchArticles()
    }

    // Update sorting query and fetch articles
    func updateSortBy(_ sortOption: String) {
        self.sortBy = sortOption
        fetchArticles()
    }
}


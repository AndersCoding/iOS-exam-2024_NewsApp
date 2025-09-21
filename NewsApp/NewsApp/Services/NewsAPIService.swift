import Foundation

class NewsAPIService {
    static let shared = NewsAPIService()
    // Gets the api key from the settings, if user wants to use own, otherwise default is used
    private var apiKey: String {
        UserDefaults.standard.string(forKey: "apiKey") ?? "1dadaed61ee14a93b4c75528d2e7d131"
    }

    // Modifies the function to take in search query from the user, and search through the api
    func fetchArticles(searchQuery: String, sortBy: String) async throws -> [Article] {
        // Check if apikey is valid, else show error
        guard !apiKey.isEmpty else {
            throw NSError(domain: "Missing API Key", code: 401, userInfo: nil)
        }

        // Use URL for the "everything"-endpoint in newsapi
        let urlString = "https://newsapi.org/v2/everything?q=\(searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&sortBy=\(sortBy)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        // Make call to api
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // JSON-ify the data received
        let decoder = JSONDecoder()
        let apiResponse = try decoder.decode(NewsAPIResponse.self, from: data)
        
        return apiResponse.articles
    }
}

import Foundation

// File for gathering the top headlines from the newsAPI
class NewsAPI_TopHeadlines {
    static let shared = NewsAPI_TopHeadlines()
    let apiKey = "1dadaed61ee14a93b4c75528d2e7d131" // Your API key

    // Fetch articles based on selected country and category
    func fetchTopHeadlines(country: String, category: String) async throws -> [Article] {
        var urlString = "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)"
        
        if country != "all" {
            urlString += "&country=\(country)"
        }
        
        if category != "all" {
            urlString += "&category=\(category)"
        }
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        // Make the api request and await the result
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the data from api
        let decoder = JSONDecoder()
        let apiResponse = try decoder.decode(NewsAPIResponse.self, from: data)
        
        return apiResponse.articles
    }
}

// Enum for required fields in the category
enum NewsCategory: String, CaseIterable, Identifiable {
    case business, entertainment, general, health, science, sports, technology

    var id: String { self.rawValue }
}

// Enum for the countries - NOTE! Only "us" works
enum NewsCountry: String, CaseIterable, Identifiable {
    case us = "us"
    case gb = "gb"
    case ca = "ca"
    case de = "de"
    case fr = "fr"
    case no = "no"
    case `in` = "in"
    
    var id: String { self.rawValue }
}



import Foundation
import SwiftData

// Model for source from API (id, name)
struct Source: Codable{
    var id: String? // Optional, since unique id may be nil, as shown in documentation
    var name: String // Name of website for source
}

// Model for Article fethed from the NewsAPI
struct Article: Codable, Identifiable {
    var id: String { url} // Id for article, based on its url, since each article has its own unique url
    var source: Source // Source of article
    var author: String? // Author, can be optional (null) on some articles, therefore optional
    var title: String // Title of article
    var description: String? // Description, can be null, therefore optional
    var url: String // URL to article
    var urlToImage: String? // URL to article image
    var publishedAt: String // date of publication
    var content: String? // Content of article, can be null, therefore optional
}

// Model for response from NewsAPI
// Fetching status, total result of articles, and the actual articles
struct NewsAPIResponse: Codable {
    var status: String // Status of response ("ok" or "error")
    var totalResults: Int // Total number of articles to be viewed
    var articles: [Article] // List of articles in an array
}

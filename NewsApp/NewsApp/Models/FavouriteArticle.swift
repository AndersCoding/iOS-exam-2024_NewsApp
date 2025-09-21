import Foundation
import SwiftData

// Implemented database
// SwiftData database for articles saved by the user, to be viewed in a list, in ArticlesView
// Users can save articles by pressing bookmark, in the ArticleDetailView, and the article will be saved in the database
// If they want to remove the saved article from the database, this is made possible with swiping right on the article

@Model
class FavouriteArticle: Identifiable {
    var id: String // Id of article
    var title: String // Title of article
    var url: String? // Url, can be null, therefore optional
    var urlToImage: String? // ImageUrl, same as url, can be null, therefore optional
    var content: String? // Content, can be null, therefore optional
    var publishedAt: String? // Date of publication, can be null, therefore optional
    var articleDescription: String?  // Description is not a valid model-variable, therefore articleDesc.

    // Constructor for the creation of new entities of favourite articles, same values as the class
    // Uses values from Article to create FavouriteArticle in the database
    init(article: Article) {
        self.id = article.id
        self.title = article.title
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.content = article.content
        self.publishedAt = article.publishedAt
        self.articleDescription = article.description
    }
}



import Foundation
import SwiftData

// Not implemented SwiftData database
// This proved to difficult to understand, due to lack of understanding the proper logic to implement this database into an allready existing database. In a fully complete application, this model would let the user save the articles they wanted, and then place the stored article within a Category-database, later to be used when they wanted to only view the articles from a specific category (sport, business, entertainment, education etc)
// I focused on creating the FavouriteArticle for the articles the user wanted to store and view later

@Model
class Category: Identifiable {
    var id = UUID() // Auto-generated ID for the saved articles on each category
    var name: String // Name of the category (sports, politics etc)
    var articles: [FavouriteArticle] // List of favourite articles that would work in unison with this database
    
    // Constructor for the creation a potentially new saved article, based on which category the user saved the article
    init(name: String, articles: [FavouriteArticle]) {
        self.name = name
        self.articles = articles
    }
}

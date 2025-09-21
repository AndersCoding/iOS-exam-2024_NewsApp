
import Foundation
import SwiftData

// Not implemented, but attempted (See SearchView for example to display saved Search-queries)
// Model for Search-database
// In a fully functional application, the search-queries from the users would be saved in this database

@Model
class Search: Identifiable{
    var id = UUID() // Auto-generated ID for each search by the user
    var searchText: String // What the user searched for
    
    // Constructor for generating Search-entities in the database
    init(id: UUID = UUID(), searchText: String) {
        self.id = id
        self.searchText = searchText
    }
}

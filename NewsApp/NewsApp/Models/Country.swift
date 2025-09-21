
import Foundation
import SwiftData

// Not implemented SwiftDatabase for the Country database
// Same as with Category, I lacked the understanding of how this database would work in unison with the application
// In a fully functioning applicaton, the user would be able to view articles based on which country they are from (which is implemented in the app, in the TopHeadlinesView), and store them based, and further on be able to view only saved articles from a specific country
@Model
class Country: Decodable{
    var id: UUID = UUID() // Auto-genered id
    var name: String // Name of country ("Norway", "Sweden", "England" etc)
    var code: String // Country code ("de", "gb", sw", "us" etc)
    
    // Constructor for saved articles
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.code = try container.decode(String.self, forKey: .code)
    }
    
    // Enum for required fields in stored Country-articles (name and code)
    enum Keys: String, CodingKey {
           case name
           case code
       }
}

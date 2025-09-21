import SwiftUI
import SwiftData

// View for a more detailed view of the article the user wants to read, with the possibility to store the selected article in the FavouriteArticle-database, by clicking the bookmark
struct ArticleDetailView: View {
    var article: Article
    @Environment(\.modelContext) private var modelContext  // Give file access to SwiftData context

    // Function to save the article as a favourite in the FavouriteArticle database
    func saveArticle() {
        let favouriteArticle = FavouriteArticle(article: article)  // Convert Article to FavouriteArticle

        do {
            modelContext.insert(favouriteArticle)  // Insert into the database
            try modelContext.save()  // Save changes
            print("Article saved to favourites!")
        } catch {
            print("Failed to save article: \(error)")
        }
    }

    // View of detailed article
    var body: some View {
        VStack {
            Text(article.title)
                .font(.title)
                .padding()

            Text(article.content ?? "No content available")
                .padding()

            // Bookmark button to save the selected article
            Button(action: {
                saveArticle()  // Save the article when button is pressed
            }) {
                Image(systemName: "bookmark.fill")  // Bookmark icon, standard icon for saving articles
                    .font(.title)
                    .foregroundColor(.yellow)
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarTitle("Article Detail", displayMode: .inline) // Title for view
    }
}

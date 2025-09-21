import SwiftUI
import SwiftData

// This view is specifically for the saved articles, from the local SwiftData database, to be viewed
struct SavedArticlesView: View {
    var article: FavouriteArticle  // Pass the selected FavouriteArticle to this view

    var body: some View {
        VStack {
            Text(article.title)
                .font(.title)
                .padding()

            Text(article.articleDescription ?? "No description available")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            // Content of the article
            if let content = article.content {
                Text(content)
                    .font(.body)
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitle("Article Details", displayMode: .inline)
    }
}


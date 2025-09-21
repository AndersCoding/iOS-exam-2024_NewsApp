import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModel()
    
    let sortingOptions = ["relevancy", "popularity", "publishedAt"] // Sorting options for user to change between which type of article they would like to view
    
    var body: some View {
        NavigationView {
            VStack {
                // Title bar for the view
                HStack {
                    Text("Search Articles")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 5)
                
                // Textfield for user input and search-button in same Hstack
                HStack {
                    TextField("Search articles...", text: $viewModel.searchQuery)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: .infinity) // Hstack fills whole screen
                    
                    // Search-button
                    Button(action: {
                        viewModel.updateSearchQuery(viewModel.searchQuery)  // When pressed will perform search from viewModel
                    }) {
                        Text("Search")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
                
                // Picker for user to change sortings of articles
                Picker("Sort By", selection: $viewModel.sortBy) {
                    ForEach(sortingOptions, id: \.self) { option in
                        Text(option.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // List of articles to be shown
                List(viewModel.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        VStack(alignment: .leading) {
                            if let imageURL = article.urlToImage, let url = URL(string: imageURL) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                            }
                            Text(article.title)
                                .font(.headline)
                            Text(article.description ?? "No description")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                         
                        }
                        .padding()
                    }
                }
                .onAppear {
                    viewModel.fetchArticles() // Fetch data when the view appears
                }
                .onChange(of: viewModel.sortBy) {newValue, _ in
                    viewModel.fetchArticles() // Re-fetch articles when sort order changes
                }
            }
        }
    }
}

#Preview {
    NewsListView()
}

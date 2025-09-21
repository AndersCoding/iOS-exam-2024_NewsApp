import SwiftUI
// View for the user to be able to search through articles, based on country, category and how many articles they would like to be shown
// As of 9/12-24, only "us" works as country, with all of the categories being functionally
// NOTE! When loading page, an errormessage will appear. This is due to no amount of articles has been selected. This can be ignored. When selecting how many articles, that number of articles will be shown without an error
struct TopHeadlinesView: View {
    @State private var selectedCountry: NewsCountry = .us // Start with "us"-country selected
    @State private var selectedCategory: NewsCategory = .general // Start with "general"-category selected
    @State private var articles: [Article] = [] // articles takes in list of Articles from api
    @State private var isLoading = false // Loading value
    @State private var numberOfArticles: Int = 0 // Start with 0 articles, for a clean view when screen appears
    
    let countries = NewsCountry.allCases // countries from NewCountry
    let categories = NewsCategory.allCases // catergories from NewsCategory
    let articleCounts = Array(1...20) // Array from 1 to 20 for number of articles the user can choose from
    
    // Fetch articles based on the selected country and category
    func fetchArticles() {
        guard numberOfArticles > 0 else {
            // If numberOfArticles is 0, don't fetch articles
            self.articles = [] // Empty if no number selected
            return
        }
        
        // Fetch from NewsAPI_TopHeadlines
        Task {
            do {
                isLoading = true
                let allArticles = try await NewsAPI_TopHeadlines.shared.fetchTopHeadlines(
                    country: selectedCountry.rawValue,
                    category: selectedCategory.rawValue
                )
                
                // Show articles based on selected number
                let filteredArticles = Array(allArticles.prefix(numberOfArticles))
                
                DispatchQueue.main.async {
                    self.articles = filteredArticles
                    isLoading = false
                }
            } catch {
                print("Error fetching articles: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
        }
    }
    
    // View for articles to be shown
    var body: some View {
        NavigationView {
            VStack {
                // Title of the view
                HStack {
                    Text("Category and Country")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 5) // Space for title
                
                // Hstack for pickers and button on same line
                HStack {
                    // Select country
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Country")
                        Picker("Select Country", selection: $selectedCountry) {
                            ForEach(countries) { country in
                                Text(country.rawValue.uppercased()).tag(country)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    // Select category
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Category")
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(categories) { category in
                                Text(category.rawValue.capitalized).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    // Select number of articles
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nr of Articles")
                        Picker("Select Number of Articles", selection: $numberOfArticles) {
                            ForEach(articleCounts, id: \.self) { count in
                                Text("\(count)").tag(count)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                
                // Searchbutton
                Button(action: {
                    fetchArticles()
                }) {
                    Text("Search")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.bottom)
                
                // Loading
                if isLoading {
                    ProgressView("Loading articles...")
                } else {
                    // List of articles to be shown
                    List(articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.headline)
                                Text(article.description ?? "No description")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                if let imageURL = article.urlToImage, let url = URL(string: imageURL) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 100)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear {
                fetchArticles()
            }
        }
    }
}

#Preview {
    TopHeadlinesView()
}

import SwiftUI

struct NewsTicker: View {
    @State private var tickerArticles: [Article] = [] // Takes in objects from the Article-model
    @State private var offset: CGFloat = 0 // Starting position for the text
    @State private var selectedHeadline: String? = nil // If optional, return nil
    @State private var isTapped: Bool = false // Boolean value for toogle-button
    @State private var tickerOffset: CGFloat = 0 // Starting position for animation
    @AppStorage("isTickerAtTop") var isTickerAtTop: Bool = true // AppStorage for userKey, used to show ticker at top or bottom - NOT IMPLEMENTED!
    @AppStorage("isTickerVisible") var isTickerVisible: Bool = true // Boolean value for toggle, for wether to display animation, or not
    @AppStorage("tickerTextColor") var tickerTextColor: String = "black" // Starting textcolor
    @AppStorage("tickerTextSize") var tickerTextSize: Double = 20  // Text size from SettingsView, either small, medium or large

    func fetchTopHeadlines() { // Fetch TopHeadlines from the NewsAPI
        Task {
            do {
                let articles = try await NewsAPI_TopHeadlines.shared.fetchTopHeadlines(country: "us", category: "general")
                let filteredArticles = articles.filter { $0.title != "[Removed]" }
                DispatchQueue.main.async {
                    self.tickerArticles = filteredArticles
                }
            } catch { // Print error, if not able to fetch
                print("Error fetching articles: \(error)")
            }
        }
    }

    func handleTap(headline: String) { // Function for tapping on the newsticker. When pressed the animation will expand
        withAnimation(.easeInOut(duration: 1)) {
            selectedHeadline = headline
            isTapped = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 1)) {
                isTapped = false
                selectedHeadline = nil
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if !tickerArticles.isEmpty {
                    let headline = tickerArticles.first?.title ?? "No headline available" // If no data to be fetched, display "No headline available"
                    
                    HStack { // Hstack for display of top headline - size can be changed from SettingsView
                        Text(headline)
                            .font(.system(size: CGFloat(tickerTextSize)))
                            .foregroundColor(getTextColor(from: tickerTextColor))
                            .padding()
                            .cornerRadius(8)
                            .scaleEffect(isTapped ? 2.0 : 1.0)
                            .offset(x: tickerOffset)
                            .onTapGesture {
                                handleTap(headline: headline)
                            }
                    }
                    .frame(width: geometry.size.width * 2)
                    .offset(x: offset)
                    .onAppear { // Start animation when opening app
                        if isTickerVisible {
                            startTickerAnimation(width: geometry.size.width, headline: headline)
                        }
                    }
                    .onChange(of: isTickerVisible) { newValue, _ in
                        if newValue {
                            startTickerAnimation(width: geometry.size.width, headline: headline)
                        } else {
                            offset = 0
                        }
                    }
                    .cornerRadius(10)
                    .opacity(isTickerVisible ? 1 : 0) // Ternary operator for animation opacity. Can be toggled from SettingsView
                    .animation(.easeInOut(duration: 0.5), value: isTickerVisible) // Smooth animation for the text
                }
            }
            .onAppear { // Fetch from API when starting animation
                fetchTopHeadlines()
            }
        }
        .frame(height: 50)
        .padding(.horizontal, -10)
    }
    
    // Function to for starting animation
    private func startTickerAnimation(width: CGFloat, headline: String) {
        let tickerWidth = width
        let totalTextWidth = CGFloat(headline.count * 10)
        let animationDuration = Double(totalTextWidth + tickerWidth) / 100.0
        
        withAnimation(.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
            offset = -tickerWidth // Text starts off-screen in beginning of animation
        }
    }
}

#Preview {
    NewsTicker()
}

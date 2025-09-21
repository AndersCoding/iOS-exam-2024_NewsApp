import SwiftUI
import SwiftData

// This file was created to test if the Search-model got updated with my search-queries, which it did not. Therefore it is not implemented in the final code and solution.
// In a fully functional application, this view would be used as an animation, when the user would enter the textfield, their past search-queries would appear below

struct SearchLogView: View {
    @Environment(\.modelContext) private var modelContext  // Access the SwiftData context
    @Query private var searchKeywords: [Search]  // Fetch previously searched keywords
    
    @State private var refreshData = false  // Used to trigger refresh

    var body: some View {
        VStack {
            if searchKeywords.isEmpty {
                Text("No previous searches.")
                    .font(.title2)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(searchKeywords) { search in
                        HStack {
                            Text(search.searchText)  // Display the search query
                            
                            Spacer()
                            
                            // "X" button to delete the search-item from database
                            Button(action: {
                                deleteSearchTerm(search)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: deleteSearchTermAtIndex)  // Swipe-to-delete
                }
                .onChange(of: refreshData) {newValue, _ in
                    // Triggered when a new search is saved, to refresh the query
                    refreshData.toggle()
                }
            }
        }
        .onAppear {
            refreshData.toggle()  // Trigger refresh when view appears
        }
//        .navigationTitle("Search Log")  // Title for
//        .padding()
    }

    // Function to delete a search object from the database
    func deleteSearchTerm(_ searchTerm: Search) {
        modelContext.delete(searchTerm)
        do {
            try modelContext.save()  // Save changes to the database
            refreshData.toggle()  // Refresh the data after deletion
        } catch {
            print("Error deleting search term: \(error)")
        }
    }

    // Function to delete a search object from database
    func deleteSearchTermAtIndex(at offsets: IndexSet) {
        for index in offsets {
            let searchTerm = searchKeywords[index] // Get the search query
            modelContext.delete(searchTerm)  // Remove the search query from database
        }

        do {
            try modelContext.save()  // Save changes to the database
            refreshData.toggle()  // Refresh the data after deletion
        } catch {
            print("Error deleting search term: \(error)")
        }
    }
}

#Preview {
    SearchLogView()
}

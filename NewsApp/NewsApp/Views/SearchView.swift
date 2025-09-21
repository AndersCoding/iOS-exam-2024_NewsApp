// View that displays NewsListView
// Used to make code in ContentView easier to understand, with a separate view with a more correct name for the purpose of Searching in the api

import SwiftUI

struct SearchView: View {
    var body: some View {
        NewsListView()
    }
}

#Preview {
    SearchView()
}

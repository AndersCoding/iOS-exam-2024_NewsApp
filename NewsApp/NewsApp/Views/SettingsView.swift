import SwiftUI
// View for the settings-page
// In this view the user can enter a personal api-key, toggle darkmode, change to turn off the newsticker-animation and change color and textsize of newsticker-animation
// Attempts where made to be able to change location of newsticker-animation (top of screen, and bottom of screen), but this proved difficult with how the stacks (Zstack etc) were being displayed
struct SettingsView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false // Boolean for darkmode
    @AppStorage("tickerTextColor") var tickerTextColor: String = "black" // Default color of text in newsticker-animation
    @AppStorage("isTickerVisible") var isTickerVisible: Bool = true // Boolean value for turning off/on newsticker-animation
    @AppStorage("tickerTextSize") var tickerTextSize: Double = 20 // Size of text in newsticker-animation
    @State private var apiKey: String = "" // Empty value for apikey, if user wants to change from default
    @State private var enteredAPIKey: String = "" // Emtpy value, if user wants to change apikey

    var body: some View {
        VStack {
            HStack { // Title for view
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                Spacer()
            }
            .padding(.top, 5)
            
            List {
                // Apikey TextField for displaying and editing key
                VStack(alignment: .leading) {
                    Text("Enter API Key")
                        .font(.title3)

                    TextField("Enter your API key", text: $enteredAPIKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            // Load the stored apikey as default
                            if let savedAPIKey = UserDefaults.standard.string(forKey: "apiKey") {
                                enteredAPIKey = savedAPIKey
                            }
                        }
                    
                    Button("Save API Key") {
                        saveAPIKey()  // Save the new apikey, if entered and pressed
                    }
                }
                .padding()

                // Dark mode toggle
                Toggle(isOn: $isDarkMode) {
                    Text("Darkmode")
                        .font(.title3)
                }
                .padding()

                // Show newsticker toggle
                Toggle(isOn: $isTickerVisible) {
                    Text("Show News Ticker")
                        .font(.title3)
                }
                .padding()

                // Picker for choosing text color in newsticker
                VStack(alignment: .leading) {
                    Text("Edit text color of NewsTicker")
                        .font(.title3)

                    Picker("Select Text Color", selection: $tickerTextColor) {
                        Text("Red").tag("red")
                        Text("Black").tag("black")
                        Text("Blue").tag("blue")
                        Text("Green").tag("green")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.leading)
                }

                // Picker for changing size of text size in newsticker animation
                VStack(alignment: .leading) {
                    Text("Edit text size in NewsTicker")
                        .font(.title3)

                    Picker("Select Text Size", selection: $tickerTextSize) {
                        Text("Small").tag(16.0) // Use Double here
                        Text("Medium").tag(20.0)
                        Text("Large").tag(24.0)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.leading)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }

    // Function for storing a users apikey, should they want to use their own
    private func saveAPIKey() {
        if !enteredAPIKey.isEmpty {
            UserDefaults.standard.set(enteredAPIKey, forKey: "apiKey")
            apiKey = enteredAPIKey  // Update the local apikey value
        }
    }
}

#Preview {
    SettingsView()
}

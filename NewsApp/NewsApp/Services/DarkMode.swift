
import Foundation
import SwiftUI

// Service to implement darkmode to the users settings

class DarkMode: ObservableObject {
    
    // Using AppStorage to be used throughout the entire app an its views
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    // Function to toggle the on/off-function for darkmode
    func toggleDarkMode(){
        isDarkMode.toggle()
    }
    
    // Implement which colorscheme to be used, when switching from light- to dark-mode
    func currentColorScheme() -> ColorScheme {
        return isDarkMode ? .dark : .light
    }
}

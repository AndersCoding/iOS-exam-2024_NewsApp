

import Foundation
import SwiftUI

// Function for the posibility to change the text of the NewsTicker-animation
// Available to change text in SettingsView
func getTextColor(from tickerTextColor: String) -> Color {
    switch tickerTextColor {
    case "red":
        return .red
    case "blue":
        return .blue
    case "green":
        return .green
    default:
        return .black // Standard color is black for all users
    }
}

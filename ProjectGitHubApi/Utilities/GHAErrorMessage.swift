import Foundation

enum GHAErrorMessage: String, Error {
    case invalidUsername = "This username created a invalid request, please try again."
    case unableToComplete = "Unable to completed your request. Please check your internet."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You have already liked them."
}

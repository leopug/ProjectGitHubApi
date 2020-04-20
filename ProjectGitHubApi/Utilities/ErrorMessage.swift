//
//  ErrorMessage.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 15/04/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import Foundation

enum GHAErrorMessage: String, Error {
    case invalidUsername = "This username created a invalid request, please try again"
    case unableToComplete = "Unable to completed your request. Please check your internet"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}

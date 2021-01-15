//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 05.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername = "This user name created an invalid request. Please try again."
    case unableToComleteRequest = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user."
}

// raw value - all cases has a one type
//enum ErrorMessage: String {
//
//    case invalidUsername = "This user name created an invalid request. Please try again."
//    case unableToComleteRequest = "Unable to complete your request. Please check your internet connection."
//    case invalidResponse = "Invalid response from the server. Please try again."
//    case invalidData = "The data recieved from the server was invalid. Please try again."
//}


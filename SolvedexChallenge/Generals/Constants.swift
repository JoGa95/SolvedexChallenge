//
//  Constants.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import Foundation

enum AppStrings: String {
    case loading = "Loading..."
    case ok = "OK"
    case errorApi = "An error occurs, please try again..."
    
    enum HomeScreen: String {
        case likesLabel = "@ Likes"
    }
}

enum API: String {
    case productsURL = "https://dog.ceo/api/breed/pug/images/random/20"
}

class Constants: NSObject {
    static let shared = Constants()
    func makeUrlRequest(_ url: String) -> URLRequest {
        let url = URL(string: url)
        return URLRequest(url: url!)
    }
}

//
//  HomeViewModelType.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import Foundation
import UIKit

protocol HomeViewModelType: ViewModelType {
    var state: HomeState { get }
    
    func getPugData(_ vc: UIViewController)
    func getSavedPugs()
    func savePug(pugsData: PugsData)
    func updatePug(imageURL: String)
}

enum HomeState: ViewModelStateType {
    case idle, started([SavedPugs])
}

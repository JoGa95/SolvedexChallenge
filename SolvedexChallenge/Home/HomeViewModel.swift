//
//  HomeViewModel.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import Foundation
import UIKit
import CoreData

final class HomeViewModel: BaseViewModel<HomeState>, HomeViewModelType {
    private let homeService: HomeService
    private let managedContext = StorageServices.shared.persistentContainer.viewContext
    
    init(homeService: HomeService) {
        self.homeService = homeService
    }
    func getPugData(_ vc: UIViewController) {
        vc.showLoader()
        self.homeService.getPugData { [weak self] result in
            vc.hideLoder()
            switch result {
            case .success(let pugsResult):
                self?.savePug(pugsData: pugsResult)
            case .failure(let error):
                vc.showAlert(message: AppStrings.errorApi.rawValue + error.localizedDescription)
            }
        }
    }
    
    func savePug(pugsData: PugsData) {
        pugsData.message.forEach {
            let localPug = NSEntityDescription.insertNewObject(forEntityName: "SavedPugs", into: managedContext) as! SavedPugs
            localPug.image = $0
            localPug.likes = 0
            do {
                try managedContext.save()
            } catch {
                
            }
        }
        self.getSavedPugs()
    }
    
    func updatePug(imageURL: String) {
        let fetchRequest = NSFetchRequest<SavedPugs>(entityName: "SavedPugs")
        let findPugByImagePredicate = NSPredicate(format: "image == %@", imageURL)
        
        do {
            fetchRequest.predicate = findPugByImagePredicate
            guard let localPug = try managedContext.fetch(fetchRequest).first else { return }
            
            localPug.likes += 1
            
            try managedContext.save()
        } catch {
            
        }
    }

    func getSavedPugs() {
        do {
            let localPugs = try managedContext.fetch(SavedPugs.fetchRequest())
            self.state = .started(localPugs)
        } catch {
            // error
        }
    }
}

//
//  StorageServices.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import Foundation
import UIKit
import CoreData

public class StorageServices {
    public static let shared = StorageServices()
    
    // MARK: Core Data Methods
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PugsDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

//
//  SavedPugs+CoreDataProperties.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//
//

import Foundation
import CoreData


extension SavedPugs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPugs> {
        return NSFetchRequest<SavedPugs>(entityName: "SavedPugs")
    }

    @NSManaged public var image: String?
    @NSManaged public var likes: Int64

}

extension SavedPugs : Identifiable {

}

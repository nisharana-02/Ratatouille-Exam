//
//  Area+CoreDataProperties.swift
//  Ratatouille-Exam
//


import Foundation
import CoreData


extension Area {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }

    @NSManaged public var isArchived: Bool
    @NSManaged public var strArea: String?
    @NSManaged public var strFlag: String?

}

extension Area : Identifiable {

}

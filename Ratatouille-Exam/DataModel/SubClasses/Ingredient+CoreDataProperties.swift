//
//  Ingredient+CoreDataProperties.swift
//  Ratatouille-Exam
//


import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var isArchived: Bool
    @NSManaged public var idIngredient: String?
    @NSManaged public var strDescription: String?
    @NSManaged public var strIngredient: String?

}

extension Ingredient : Identifiable {

}

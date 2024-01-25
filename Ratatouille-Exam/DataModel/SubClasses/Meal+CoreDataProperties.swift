//
//  Meal+CoreDataProperties.swift
//  Ratatouille-Exam
//


import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var idMeal: String?
    @NSManaged public var strMeal: String?
    @NSManaged public var strArea: String?
    @NSManaged public var strCategory: String?
    @NSManaged public var strIngredient1: String?
    @NSManaged public var strIngredient2: String?
    @NSManaged public var strIngredient3: String?
    @NSManaged public var strIngredient4: String?
    @NSManaged public var strInstructions: String?
    @NSManaged public var strMealThumb: String?
    @NSManaged public var isArchived: Bool
    @NSManaged public var isFav: Bool
    @NSManaged public var isDel: Bool

}

extension Meal : Identifiable {

}

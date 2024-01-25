//
//  Category+CoreDataProperties.swift
//  Ratatouille-Exam
//


import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var idCategory: String?
    @NSManaged public var isArchived: Bool
    @NSManaged public var strCategory: String?
    @NSManaged public var strCategoryDescription: String?
    @NSManaged public var strCategoryThumb: String?

}

extension Category : Identifiable {

}

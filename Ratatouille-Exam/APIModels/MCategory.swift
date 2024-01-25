//
//  MCategory.swift
//  Ratatouille-Exam
//
//  

import Foundation

// data Response object for Category data API
struct MCategoryResponse :  Codable{
   
    
    let  categories : [MCategory]
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}


struct MCategory : Hashable, Codable{
  
    let   idCategory : String
    let   strCategory :String
    let   strCategoryDescription :String
    let   strCategoryThumb :String
    
}

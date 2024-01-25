//
//  MMeal.swift
//  Ratatouille-Exam
//
// 
//

import Foundation

struct MMealResponse :  Codable{
   
    
    let meals : [MMeal]
}


struct MMeal:Hashable, Codable{
  
    let   idMeal : String
    let   strMeal :String
    let   strCategory :String?
    let   strArea :String?
    let   strInstructions:String?
    let   strMealThumb: String
    let   strIngredient1: String?
    let   strIngredient2: String?
    let   strIngredient3: String?
    let   strIngredient4: String?
   
    
}

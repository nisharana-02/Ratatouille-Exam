//
//  MIngredient.swift
//  Ratatouille-Exam
//

//

import Foundation




struct MIngredientResponse :  Codable{
   
    
    let ingredients : [MIngredient]
    enum CodingKeys: String, CodingKey {
           case ingredients = "meals"
       }
}




struct MIngredient:Hashable, Codable{
  
    let   idIngredient : String
    let   strIngredient :String?
    let   strDescription :String?
    
}


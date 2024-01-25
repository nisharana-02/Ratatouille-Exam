//
//  MArea.swift
//  Ratatouille-Exam
//
//
import Foundation

struct MAreaResponse:  Codable{
   
    let  areas : [MArea]
    
    enum CodingKeys: String, CodingKey {
        case areas = "meals"
    }
}


struct MArea : Hashable, Codable{
  
  
    let   strArea :String
    let   strFlag : String?
}


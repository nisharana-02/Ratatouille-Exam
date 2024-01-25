//
//  CIngredient.swift
//  Ratatouille-Exam


import Foundation
import CoreData

class CIngredient : ObservableObject{
    @Published var mIngredientResponse : MIngredientResponse?
    @Published var mIngredient : [MIngredient] = []
    @Published var filteredSpecificMealsFromApiResponse : MMealResponse?
    @Published var filteredSpecificMealsFromApi : [MMeal] = []
    let persistance = Persistance.instance
    
  @Published var dbIngredientRecords : [EIngredient] = []
    
    init(){
        getDBIngredients()
        getAPIIngredients()
        
    }
 
    func filterMealsByIngredient(strIngredient: String){
        let mvm = CIngredient()
        let customUrl =  "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(strIngredient)"
 
        
        
        guard  let url = URL(string: customUrl) else {
            print("url feil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            guard let data = data, error == nil else {
                print("ingen data funnet")
                return
            }
          
            do{
                let apiResponse = try JSONDecoder().decode(MMealResponse.self,from: data)
               
               
            
               DispatchQueue.main.async {
                   
                   self.filteredSpecificMealsFromApiResponse = apiResponse
                   self.filteredSpecificMealsFromApi = apiResponse.meals
                }
               
            }
            catch{
                print(error)
            }
        }
        task.resume()
      
    }
    
    
    func getAPIIngredients(){
        guard  let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?i=list") else {
            print("url feil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            guard let data = data, error == nil else {
                print("ingen data funnet")
                return
            }
           
            do{
                let mIngredientResponse = try JSONDecoder().decode(MIngredientResponse.self,from: data)
               
               
               DispatchQueue.main.async {
                   self.mIngredientResponse = mIngredientResponse
                   self.mIngredient = mIngredientResponse.ingredients
                   self.getDataFromApiAndStoreInDB(data: self.mIngredient)
                   
                  
                }
               
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
   
    
    
   
    func getDBIngredients(){
        
        let requestIngredientEntity = NSFetchRequest<EIngredient>(entityName: "EIngredient")
        
     
        do{
            dbIngredientRecords  =  try persistance.dbContext.fetch(requestIngredientEntity)
           
            
            
            
        } catch{
            print("Feil ved lasting")
        }
    }
    
    
    
    
    func getDBSpecificIngredient(strIngredient: String) -> Bool{
        
        let requestIngredientEntity = NSFetchRequest<EIngredient>(entityName: "EIngredient")
        
        let predicate = NSPredicate(format: "strIngredient ='\(strIngredient)' ")
        requestIngredientEntity.predicate = predicate
        var result = false
        do{
          let record =  try persistance.dbContext.fetch(requestIngredientEntity)
            if (record.count != 0){
                result =  true
            }
            
            
            
        } catch{
            print("Feil ved lasting")
        }
        return result
    }
  

    
    func  addIngredientRecord(idIngredient : String, strDescription :String, strIngredient :String){
        
        if (getDBSpecificIngredient(strIngredient : strIngredient ) == false) {
            let newIngredientRecord = EIngredient(context: persistance.dbContext)
            newIngredientRecord.idIngredient =  idIngredient
            newIngredientRecord.strIngredient =  strIngredient
            newIngredientRecord.strDescription = strDescription
            
            saveIngredientRecord()
        }
    }
        func getDataFromApiAndStoreInDB(data: [MIngredient]){
            
            
            for record in data {
                addIngredientRecord(idIngredient:record.idIngredient, strDescription: record.strDescription ?? "" , strIngredient: record.strIngredient ?? "")
              
            }
            
        }
    
    func archivedIngredientRecord(index: Int){
   
           let ingredient =  dbIngredientRecords [index]
        ingredient.isArchived = true
           saveIngredientRecord()
           
       }
       func nonArchivedIngredientRecord(index: Int){
      
           let ingredient =  dbIngredientRecords [index]
           ingredient.isArchived = false
           saveIngredientRecord()
           
       }
    
    func deleteIngredientRecord(index: Int){
        let ingredient =  dbIngredientRecords [index]
        persistance.dbContext.delete(ingredient)
        saveIngredientRecord()
        
    }
    
    func saveIngredientRecord(){
       
        
            persistance.dbSave()
            getDBIngredients()
        
    }
}

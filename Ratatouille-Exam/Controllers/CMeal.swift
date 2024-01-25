//
//  CMeal.swift
//  Ratatouille-Exam


import Foundation
import CoreData

class CMeal : ObservableObject{
    @Published var mMealResponse : MMealResponse?
    @Published var mMeals : [MMeal] = []
    let persistance = Persistance.instance
    
  @Published var dbMealRecords : [EMeal] = []
    
    init(){
        getDBMeals()
        getAPIMeals()
        
    }
 
    
    func getAPIMeals(){
        guard  let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood") else {
            print("url feil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            guard let data = data, error == nil else {
                print("ingen data funnet")
                return
            }
           
            do{
                let mMealResponse = try JSONDecoder().decode(MMealResponse.self,from: data)
               
               
               DispatchQueue.main.async {
                   self.mMealResponse = mMealResponse
                   self.mMeals = mMealResponse.meals
                   self.getDataFromApiAndStoreInDB(data: self.mMeals)
                   
                   for meal in self.mMeals {
                       self.getAPIMeals(idMeal: meal.idMeal)
                   }
                }
               
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
   
    
    func getAPIMeals(idMeal: String)->Void{
      
        
        guard  let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            print("url feil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            guard let data = data, error == nil else {
                print("ingen data funnet")
                return
            }
           
            do{
                let mMealResponse = try JSONDecoder().decode(MMealResponse.self,from: data)
               
               
               DispatchQueue.main.async {
                   self.mMealResponse = mMealResponse
                   self.mMeals = mMealResponse.meals
                   self.getDetailsFromApiAndStoreInDB(data: self.mMeals)
                
                }
               
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    func getDetailsFromApiAndStoreInDB(data:[MMeal]){
        let myMeals = dbMealRecords
        for meal in myMeals{
            for dm in data{
                if meal.idMeal == dm.idMeal{
                    if meal.strIngredient1 == ""{
                        meal.strIngredient1 = dm.strIngredient1
                    }
                    if meal.strIngredient2 == ""{
                        meal.strIngredient2 = dm.strIngredient2
                    }
                    if meal.strIngredient3 == ""{
                        meal.strIngredient3 = dm.strIngredient3
                    }
                    if meal.strIngredient4 == ""{
                        meal.strIngredient4 = dm.strIngredient4
                    }
                    
                    meal.strInstructions = dm.strInstructions
                
                }
                
                
            }
            
            
        }
        dbMealRecords = myMeals
        saveMealRecord()
        
    }
    
    
   
    func getDBMeals(){
        
        let requestMealEntity = NSFetchRequest<EMeal>(entityName: "EMeal")
        
     
        do{
            dbMealRecords  =  try persistance.dbContext.fetch(requestMealEntity)
           
            
            
            
        } catch let error{
            print("Feil ved henting \(error)")
        }
    }
    
    
    
    // get specific record from db
      func fetchSpecificMealRecords(idMeal: String) -> Bool{
          
          let requestMealEntity = NSFetchRequest<EMeal>(entityName: "EMeal")
          
          let predicate = NSPredicate(format: "idMeal ='\(idMeal)' ")
          requestMealEntity.predicate = predicate
          var result = false
          do{
            let record =  try persistance.dbContext.fetch(requestMealEntity)
              if (record.count != 0){
                  result =  true
              }
              
              
              
          } catch let error{
              print("Feil ved henting \(error)")
          }
          return result
      }
    
    
    func  addMealRecord(idMeal: String, strMeal: String, strCategory:String, strArea:String,strInstructions:String,strMealThumb: String, isArchived : Bool? ){
        if (fetchSpecificMealRecords(idMeal: idMeal  ) == false) {
            let newMealRecord = EMeal(context: persistance.dbContext)
            newMealRecord.idMeal = idMeal
            newMealRecord.strMeal = strMeal
            newMealRecord.strCategory = strCategory
            newMealRecord.strArea = strArea
            newMealRecord.strInstructions = strInstructions
            newMealRecord.strMealThumb = strMealThumb
            newMealRecord.isArchived = isArchived ?? false
            saveMealRecord()
        }
    }
    
    
    func getDataFromApiAndStoreInDB(data: [MMeal]){
        
       
        for record in data{
            
         addMealRecord(idMeal: record.idMeal, strMeal:record.strMeal, strCategory: record.strCategory ?? "", strArea: record.strArea ?? "", strInstructions: record.strInstructions ?? "", strMealThumb: record.strMealThumb, isArchived: false)
        }
        
    }
    
    func updateMealIngredients(
        idMeal : String,
        strIngredient1 : String ,
        strIngredient2 : String ,
        strIngredient3 : String ,
        strIngredient4 : String 
    )
    {
        let myMeals = dbMealRecords
        for meal in myMeals{
            if meal.idMeal == idMeal{
                meal.strIngredient1 = strIngredient1
                meal.strIngredient2 = strIngredient2
                meal.strIngredient3 = strIngredient3
                meal.strIngredient4 = strIngredient4
                
            }
        }
        dbMealRecords = myMeals
        saveMealRecord()
    }
    
    
    
    func deleteMealRecord(index: Int){
        let meal =  dbMealRecords [index]
        persistance.dbContext.delete(meal)
        saveMealRecord()
        
    }

    
    
    func archivedMealRecord(index: Int){
   
           let meal =  dbMealRecords [index]
          meal.isArchived = true
           saveMealRecord()
           
       }
       func nonArchivedMealRecord(index: Int){
      
           let meal =  dbMealRecords [index]
          meal.isArchived = false
           saveMealRecord()
           
       }
    
    func favMealRecord (index: Int){
        let meal =  dbMealRecords [index]
        meal.isFav = !meal.isFav
        saveMealRecord()
    }
    
    
    
    
    
    
    
    func saveMealRecord(){
       
            persistance.dbSave()
            getDBMeals()
        
    }
}

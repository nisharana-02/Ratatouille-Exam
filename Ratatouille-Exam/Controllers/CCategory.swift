//
//  CCategory.swift
//  Ratatouille-Exam


import Foundation
import CoreData

class CCategory : ObservableObject{
    @Published var mCategoryResponse : MCategoryResponse?
    @Published var mCategory : [MCategory] = []
    @Published var filteredSpecificMealsFromApiResponse : MMealResponse?
    @Published var filteredSpecificMealsFromApi : [MMeal] = []
    let persistance = Persistance.instance
    
  @Published var dbCategoryRecords : [ECategory] = []
    
    init(){
        getDBCategories()
        getAPICategories()
        
    }
 
    func filterMealsByCategory(strCategory: String){

        let customUrl =  "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(strCategory)"
 
        
        
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
    
    
    func getAPICategories(){
        guard  let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            print("url feil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            guard let data = data, error == nil else {
                print("ingen data funnet")
                return
            }
           
            do{
                let mCategoryResponse = try JSONDecoder().decode(MCategoryResponse.self,from: data)
               
               
               DispatchQueue.main.async {
                   self.mCategoryResponse = mCategoryResponse
                   self.mCategory = mCategoryResponse.categories
                   self.getDataFromApiAndStoreInDB(data: self.mCategory)
                   
                  
                }
               
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
   
    
    
   
    func getDBCategories(){
        
        let requestCategoryEntity = NSFetchRequest<ECategory>(entityName: "ECategory")
        
     
        do{
            dbCategoryRecords  =  try persistance.dbContext.fetch(requestCategoryEntity)
           
            
            
            
        } catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    
    
    
    func getDBSpecificCategory(idCategory: String) -> Bool{
        
        let requestCategoryEntity = NSFetchRequest<ECategory>(entityName: "ECategory")
        
        let predicate = NSPredicate(format: "idCategory ='\(idCategory)' ")
        requestCategoryEntity.predicate = predicate
        var result = false
        do{
          let record =  try persistance.dbContext.fetch(requestCategoryEntity)
            if (record.count != 0){
                result =  true
            }
            
            
            
        } catch let error{
            print("Error fetching. \(error)")
        }
        return result
    }
  
    
    func  addCategoryRecord(idCategory: String, strCategory: String, strCategoryDescription:String, strCategoryThumb:String, isArchived: Bool?){
        if (getDBSpecificCategory(idCategory : idCategory ) == false) {
            let newCategoryRecord = ECategory(context: persistance.dbContext)
            newCategoryRecord.idCategory = idCategory
            newCategoryRecord.strCategory = strCategory
            newCategoryRecord.strCategoryDescription = strCategoryDescription
            newCategoryRecord.strCategoryThumb = strCategoryThumb
            newCategoryRecord.isArchived = isArchived ?? false
            saveCategoryRecord()
        }
        
    }
    
    
    
    
    
    func getDataFromApiAndStoreInDB(data: [MCategory]){
        
   
        for record in data{
            addCategoryRecord(idCategory:record.idCategory, strCategory: record.strCategory, strCategoryDescription: record.strCategoryDescription, strCategoryThumb:record.strCategoryThumb,
            isArchived: false
            )
            
      
        }
        
    }
    func archivedCategoryRecord(index: Int){
   
           let category =  dbCategoryRecords [index]
          category.isArchived = true
           saveCategoryRecord()
           
       }
       func nonArchivedCategoryRecord(index: Int){
      
           let category =  dbCategoryRecords [index]
          category.isArchived = false
           saveCategoryRecord()
           
       }
    
    func deleteCategoryRecord(index: Int){
        let category =  dbCategoryRecords [index]
        persistance.dbContext.delete(category)
        saveCategoryRecord()
        
    }
    
    func saveCategoryRecord(){
       
        
            persistance.dbSave()
            getDBCategories()
        
    }
}

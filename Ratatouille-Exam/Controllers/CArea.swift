//
//  CArea.swift
//  Ratatouille-Exam


import Foundation
import CoreData

class CArea : ObservableObject{
    @Published var mAreaResponse : MAreaResponse?
    @Published var mArea : [MArea] = []
    @Published var filteredSpecificMealsFromApiResponse : MMealResponse?
    @Published var filteredSpecificMealsFromApi : [MMeal] = []
    let persistance = Persistance.instance
    
  @Published var dbAreaRecords : [EArea] = []
    
    init(){
        getDBAreas()
        getAPIAreas()
        
    }
 
    func filterMealsByArea(strArea: String){
        
        let customUrl =  "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(strArea)"
 
        
        
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
    
    
    func getAPIAreas(){
        guard  let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?a=list") else {
            print("url feil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,_,error in
            guard let data = data, error == nil else {
                print("ingen data funnet")
                return
            }
           
            do{
                let mAreaResponse = try JSONDecoder().decode(MAreaResponse.self,from: data)
               
               
               DispatchQueue.main.async {
                   self.mAreaResponse = mAreaResponse
                   self.mArea = mAreaResponse.areas
                   self.getDataFromApiAndStoreInDB(data: self.mArea)
                   
                  
                }
               
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
   
    
    
   
    func getDBAreas(){
        
        let requestAreaEntity = NSFetchRequest<EArea>(entityName: "EArea")
        
     
        do{
            dbAreaRecords  =  try persistance.dbContext.fetch(requestAreaEntity)
           
            
            
            
        } catch{
            print("Feil ved lasting")
        }
    }
    
    
    
    
    func getDBSpecificArea(strArea: String) -> Bool{
        
        let requestAreaEntity = NSFetchRequest<EArea>(entityName: "EArea")
        
        let predicate = NSPredicate(format: "strArea ='\(strArea)' ")
        requestAreaEntity.predicate = predicate
        var result = false
        do{
          let record =  try persistance.dbContext.fetch(requestAreaEntity)
            if (record.count != 0){
                result =  true
            }
            
            
            
        } catch{
            print("Feil ved lasting")
        }
        return result
    }
  
    
    
    func getFlagByArea(area : String)-> String{
   
            let countryCodes  = [
                    "American"   : "https://flagsapi.com/US/shiny/64.png"  ,
                    "British"    : "https://flagsapi.com/GB/shiny/64.png"  ,
                    "Canadian"   : "https://flagsapi.com/CA/shiny/64.png"  ,
                    "Chinese"    : "https://flagsapi.com/CN/shiny/64.png"  ,
                    "Croatian"   : "https://flagsapi.com/HR/shiny/64.png"  ,
                    "Dutch"      : "https://flagsapi.com/NL/shiny/64.png"  ,
                    "Egyptian"   : "https://flagsapi.com/EG/shiny/64.png"  ,
                    "Filipino"   : "https://flagsapi.com/PH/shiny/64.png"  ,
                    "French"     : "https://flagsapi.com/FR/shiny/64.png"  ,
                    "Greek"      : "https://flagsapi.com/GR/shiny/64.png"  ,
                    "Indian"     : "https://flagsapi.com/IN/shiny/64.png"  ,
                    "Irish"      : "https://flagsapi.com/IE/shiny/64.png"  ,
                    "Italian"    : "https://flagsapi.com/IT/shiny/64.png"  ,
                    "Jamaican"   : "https://flagsapi.com/JM/shiny/64.png"  ,
                    "Japanese"   : "https://flagsapi.com/JP/shiny/64.png"  ,
                    "Kenyan"     : "https://flagsapi.com/KE/shiny/64.png"  ,
                    "Malaysian"  : "https://flagsapi.com/MY/shiny/64.png"  ,
                    "Mexican"    : "https://flagsapi.com/MX/shiny/64.png"  ,
                    "Moroccan"   : "https://flagsapi.com/MA/shiny/64.png"  ,
                    "Polish"     : "https://flagsapi.com/PL/shiny/64.png"  ,
                    "Portuguese" : "https://flagsapi.com/PT/shiny/64.png"  ,
                    "Russian"    : "https://flagsapi.com/RU/shiny/64.png"  ,
                    "Spanish"    : "https://flagsapi.com/ES/shiny/64.png"  ,
                    "Thai"       : "https://flagsapi.com/TH/shiny/64.png"  ,
                    "Tunisian"   : "https://flagsapi.com/TN/shiny/64.png"  ,
                    "Turkish"    : "https://flagsapi.com/TR/shiny/64.png"  ,
                    "Vietnamese" : "https://flagsapi.com/VN/shiny/64.png"  ,
                    "Unknown"    : "https://flagsapi.com/BE/shiny/64.png"  ,
                ]
          var flagUrl = ""
        print(area)
        for country in countryCodes{
            
            if(country.key == area){
                flagUrl =  country.value
            }
            
        }
        
        return flagUrl
    }
    
    func  addAreaRecord( strArea: String){
        if (getDBSpecificArea(strArea : strArea ) == false) {
            
            
            let newAreaRecord = EArea(context: persistance.dbContext)
            
            newAreaRecord.strArea = strArea
            newAreaRecord.strFlag = getFlagByArea(area : strArea)
            
            saveAreaRecord()
        }
        
    }
    
    
    func getDataFromApiAndStoreInDB(data: [MArea]){
        
   
        for record in data {
            addAreaRecord(strArea: record.strArea)
          
      }
        
    }
    func archivedAreaRecord(index: Int){
   
           let area =  dbAreaRecords [index]
         area.isArchived = true
           saveAreaRecord()
           
       }
       func nonArchivedAreaRecord(index: Int){
      
           let area =  dbAreaRecords [index]
           area.isArchived = false
           saveAreaRecord()
           
       }
    
    func deleteAreaRecord(index: Int){
        let area =  dbAreaRecords [index]
        persistance.dbContext.delete(area)
        saveAreaRecord()
        
    }
    
    func saveAreaRecord(){
       
        
            persistance.dbSave()
            getDBAreas()
        
    }
}

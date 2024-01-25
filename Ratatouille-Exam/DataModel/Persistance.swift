//
//  Persistance.swift
//  Ratatouille-Exam
//
//
//

import CoreData

class  Persistance {
    
    static let instance = Persistance()
    
    let dbContainer : NSPersistentContainer
    let dbContext : NSManagedObjectContext
    
    init(){
      dbContainer = NSPersistentContainer(name: "RatatouilleDB")
        dbContainer.loadPersistentStores { (_, error) in
            if let _ = error{
                print("Feil")
            }
        }
        dbContext = dbContainer.viewContext
     
    }
    func dbSave(){
        do{
            try dbContext.save()
        }catch {
            print("Feil ved lagring")
            
        }
    }
}


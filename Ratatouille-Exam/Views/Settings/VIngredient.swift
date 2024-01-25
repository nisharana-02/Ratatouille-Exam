//
//  VIngredient.swift
//  Ratatouille-Exam
//


import Foundation
import SwiftUI
struct VIngredient: View {
    
    @StateObject var cIngredient = CIngredient()
    @State var ingredientTextFieldName: String = ""
    @State var errorMessage: String = ""
    
    
    
    var body: some View {
      
            VStack(spacing: 20) {
            
               
                    List{
                        Section{
                            
                            ForEach(cIngredient.dbIngredientRecords.indices, id: \.self){ index in
                                let row = cIngredient.dbIngredientRecords[index]
                                if row.isArchived{
                                    Text(row.strIngredient ?? "Ingen ingredienser funnet")
                                        .swipeActions(edge:.trailing){
                                            Button {
                                                cIngredient.nonArchivedIngredientRecord( index: index)
                                                cIngredient.dbIngredientRecords.remove(at: index)
                                            } label: {
                                                
                                                Label("Arkiver", systemImage: "archivebox.fill")
                                            }
                                            .tint(.blue)
                                        }
                                }
                                
                            }
                            
                            
                        }header: {
                            Text("Ingredienser fra database")
                            
                        }
                    }.listStyle(PlainListStyle())
                    
        
                }
                .navigationTitle("Ingrediens")
                .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
                .navigationBarItems(trailing: NavigationLink(destination: EVIngredient()) {
                    Image(systemName: "pencil.circle.fill")
                })
               
            }
        }

struct EVIngredient: View {
    
    @StateObject var cIngredient = CIngredient()
    @State var ingredientTextFieldName: String = ""
    @State var errorMessage: String = ""
    
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            
            List{
                
              
                Section{
                    
                    ForEach(cIngredient.dbIngredientRecords.indices, id: \.self){ index in
                        let row = cIngredient.dbIngredientRecords[index]
                        if !row.isArchived{
                            Text(row.strIngredient ?? "Ingen ingrediens funnet")
                                .swipeActions(edge:.trailing){
                                    Button {
                                        cIngredient.archivedIngredientRecord( index: index)
                                        cIngredient.dbIngredientRecords.remove(at: index)
                                    } label: {
                                        Label("Arkiver", systemImage: "archivebox.fill")
                                    }
                                    .tint(.blue)
                                }
                            
                        }
                        
                    }
                    
                    
                    
                }header: {
                    Text("Ingredienser fra database")
                    
                }
            }.listStyle(PlainListStyle())
            
            
            
                .navigationTitle("Ingrediens")
                .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
            
        }
    }
}

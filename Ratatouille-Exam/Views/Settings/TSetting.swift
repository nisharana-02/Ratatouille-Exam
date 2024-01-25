//
//  TSetting.swift
//  Ratatouille-Exam
//
//
//
import SwiftUI
import Foundation
struct TSetting: View {
    var body: some View {
        NavigationView {
            List {
              
                Section(header: Text("Seksjon 1")) {
                    NavigationLink(destination: VArea()) {
                        Text("Områder")
                    }
                    .padding(8)
                    NavigationLink(destination: VCategory()) {
                        Text("Kategori")
                    }
                    .padding(8)
                    NavigationLink(destination: VIngredient()) {
                        Text("Ingredienser")
                    }
                    .padding(8)
                }
                
              
                Section(header: Text("Mørk/Lys Modus")) {
                    Toggle("Mørk modus", isOn: .constant(false))
                }
                
            
                Section(header: Text("Arkiv")) {
                    NavigationLink(destination: TSArchives()) {
                        Text("Gå til Arkiv")
                    }
                }
                
            }
            .padding(8)
            .listStyle(GroupedListStyle())
            .navigationTitle("Innstillinger")
        }
        .padding(8)
        
    }
}

struct TSArchives: View {
    
   
    @StateObject var cMeal = CMeal()
    @StateObject var cCategory = CCategory()
    @StateObject var cArea = CArea()
    @StateObject var cIngredient = CIngredient()
    
    var body: some View {
        List {
            Section{
                
                ForEach(cArea.dbAreaRecords.indices, id: \.self){ index in
                    let row = cArea.dbAreaRecords[index]
                    if row.isArchived{
                        
                        
                        HStack{
                            
                            AsyncImage(url: URL(string:row.strFlag ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            Text(row.strArea ?? "Ingen områder funnet")
                        }
                        .swipeActions(edge:.trailing){
                            Button {
                                cArea.nonArchivedAreaRecord( index: index)
                                cArea.dbAreaRecords.remove(at:index)
                            } label: {
                                Label("Arkiver", systemImage: "archivebox.fill")
                            }
                            .tint(.blue)
                        }
                    
                    }
                    
                }
     
                
            }header: {
                Text("Områder fra database")
                
            }
            
            Section{
                
                ForEach(cCategory.dbCategoryRecords.indices, id: \.self){ index in
                    let row = cCategory.dbCategoryRecords[index]
                    if row.isArchived{
                        Text(row.strCategory ?? "Ingen kategorier funnet")
                            .swipeActions(edge:.trailing){
                                Button {
                                    cCategory.archivedCategoryRecord( index: index)
                                    cCategory.dbCategoryRecords.remove(at:index)
                                } label: {
                                    Label("Arkiver", systemImage: "archivebox.fill")
                                }
                                .tint(.blue)
                            }
                        
                    }
                    
                }
                
                
                
            }header: {
                Text("Kategorier")
                
            }
            
            
            Section{
                
                ForEach(cIngredient.dbIngredientRecords.indices, id: \.self){ index in
                    let row = cIngredient.dbIngredientRecords[index]
                    if row.isArchived{
                        Text(row.strIngredient ?? "Ingen ingredienser funnet")
                            .swipeActions(edge:.trailing){
                                Button {
                                    cIngredient.nonArchivedIngredientRecord( index: index)
                                    cIngredient.dbIngredientRecords.remove(at:index)
                                } label: {
                                    Label("Arkiver", systemImage: "archivebox.fill")
                                }
                                .tint(.blue)
                            }
                        
                        
                    }
                }
                
                
            }header: {
                Text("Ingredienser")
                
            }
            
        }.listStyle(PlainListStyle())
    }
}


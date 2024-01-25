//
//  VCategory.swift
//  Ratatouille-Exam
//
//
//

import Foundation
import SwiftUI
struct VCategory: View {
    
    @StateObject var cCategory = CCategory()
    @State var categoryTextFieldName: String = ""
    @State var errorMessage: String = ""
    
    
    
    var body: some View {
        
            VStack(spacing: 20) {
            
               
                    List{
                        Section{
                            
                            ForEach(cCategory.dbCategoryRecords.indices, id: \.self){ index in
                                let row = cCategory.dbCategoryRecords[index]
                                if row.isArchived{
                                    
                                    
                                    Text(row.strCategory ?? "Ingen kategorier funnet")
                                        .swipeActions(edge:.trailing){
                                            Button {
                                            cCategory.archivedCategoryRecord( index: index)
                                                cCategory.dbCategoryRecords.remove(at: index)
                                            } label: {
                                                Label("Arkiver", systemImage: "archivebox.fill")
                                            }
                                            .tint(.blue)
                                        }
                                }
                                    
                                
                                    
                            }
                            
                            
                        }header: {
                            Text("Kategorier fra database")
                            
                        }
                    }.listStyle(PlainListStyle())
                    
        
                
                .navigationTitle("Kategorier")
                .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
                .navigationBarItems(trailing: NavigationLink(destination: EVCategory()) {
                    Image(systemName: "pencil.circle.fill")
                })
               
            }
        }
    }

struct EVCategory: View {
    
    @StateObject var cCategory = CCategory()
    @State var categoryTextFieldName: String = ""
    @State var errorMessage: String = ""
    
    
    
    var body: some View {
        
            VStack(spacing: 20) {
               
                    List{
    
                        Section{
                            
                            ForEach(cCategory.dbCategoryRecords.indices, id: \.self){ index in
                                let row = cCategory.dbCategoryRecords[index]
                                if !row.isArchived{
                                    
                                    
                                    Text(row.strCategory ?? "Ingen kategorier funnet")
                                        .swipeActions(edge:.trailing){
                                            Button {
                                                cCategory.archivedCategoryRecord( index: index)
                                                cCategory.dbCategoryRecords.remove(at: index)
                                            } label: {
                                                Label("Arkiver", systemImage: "archivebox.fill")
                                            }
                                            .tint(.blue)
                                        }
                                }
                                    
                                
                                    
                            }
                            
                        }header: {
                            Text("Kategorier fra database")
                            
                        }
                    }.listStyle(PlainListStyle())
                    
        
                
                .navigationTitle("Kategorier")
                .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
            }
        }
    }



//
//  VArea.swift
//  Ratatouille-Exam
//
//
//

import Foundation
import SwiftUI
import CoreData


struct VArea: View {
    
    @StateObject var cArea = CArea()
    @State var areaTextFieldName: String = ""
    @State var errorMessage: String = ""
    
    
    
    var body: some View {
       
            VStack(spacing: 20) {
            
               
                    List{
                    
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
                                        cArea.dbAreaRecords.remove(at: index)
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
                        
                    }.listStyle(PlainListStyle())
                    
        
                }
                .navigationTitle("Områder")
                .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
                .navigationBarItems(trailing: NavigationLink(destination: EVArea()) {
                    Image(systemName: "pencil.circle.fill")
                })
               
            }
        }
    
struct EVArea: View {
    
    @StateObject var cArea = CArea()
    @State var areaTextFieldName: String = ""
    @State var errorMessage: String = ""
    
    
    
    var body: some View {
        
            VStack(spacing: 20) {
            
               
                    List{
                    
                        Section{
                            
                            ForEach(cArea.dbAreaRecords.indices, id: \.self){ index in
                                let row = cArea.dbAreaRecords[index]
                                if !row.isArchived{
                                    
                               
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
                                        cArea.archivedAreaRecord( index: index)
                                        cArea.dbAreaRecords.remove(at: index)
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
                        
                    }.listStyle(PlainListStyle())
                    
        
                
                .navigationTitle("Områder")
                .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
            
               
            }
        }
    }






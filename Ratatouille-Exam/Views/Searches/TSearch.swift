//
//  TSearch.swift
//  Ratatouille-Exam
//
//
//

import SwiftUI
import Foundation


struct TSearch : View {
    
    
   
    @State  var cMeal = CMeal()
    
  
    @StateObject var cCategory = CCategory()
  
    
    
    @StateObject var cArea = CArea()
  
    
   
    @StateObject var cIngredient = CIngredient()
   
    
    
    
    @State var  errorMessage : String = ""
    @State var textFieldName : String = ""
    
    
    @State var selection: String = "Area"
    let options : [String] = ["Område","Kategori","Ingrediens"]
    
    
    func   resetErrorMessage(){
        errorMessage = ""
    }
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                List{
                    
                    Section{
                        Picker(
                            selection: $selection,
                            label: Text("picker"),
                            content: {
                                ForEach(options.indices){ index in
                                    Text(options[index])
                                        .tag(options[index])
                                }
                            }
                            
                        )
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selection) { newValue in
                            // Handle the change of the selection value
                            errorMessage = ""
                            textFieldName = ""
                            
                        }
                        
                    }header: {
                        Text("")
                    }
                    
                    
                    // edit textfield area
                    Section{
                        
                        Text( "\(errorMessage) ")
                        TextField("Tast inn \(selection)" , text: $textFieldName)
                            .font(.headline)
                            .padding(.leading)
                            .frame(height: 55)
                            .background(Color .white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        
                        Button(action :{
                            guard !textFieldName.isEmpty else  {
                                
                                errorMessage = "\( selection) er nødvendig"
                                return}
                            
                            if (selection == options[0]){
                                
                                
                              
                                cArea.filterMealsByArea(strArea: textFieldName)
                                
                                
                            }else if (selection == options[1]){
                                
                               
                                
                                cCategory.filterMealsByCategory(strCategory: textFieldName)
                                
                                
                            }else if (selection == options[2]){
                                
                               
                                
                                cIngredient.filterMealsByIngredient(strIngredient: textFieldName)
                                
                            }
                            
                            
                            
                          
                            textFieldName = ""
                        }, label: {
                            Text("Søk mat \(selection)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color(.pink))
                                .cornerRadius(10)
                        })
                        
                        .padding(.horizontal)
                        
                        
                        
                        
                        
                    }header: {
                        Text("")
                    }
                    
                
                    
                    Section{
                        if (selection == options[0]){
                           
                          
                            
                            
                            ForEach(cArea.filteredSpecificMealsFromApi.indices, id: \.self ){ index in
                                MRVSearch(recipe: cArea.filteredSpecificMealsFromApi[index])
                               .padding(.vertical, 8)
                                      
                                       .swipeActions(edge:.trailing){
                                           Button {
                        cMeal.addMealRecord(idMeal: cArea.filteredSpecificMealsFromApi[index].idMeal, strMeal:cArea.filteredSpecificMealsFromApi[index].strMeal,
                        strCategory: cArea.filteredSpecificMealsFromApi[index].strCategory ?? "",
                                                strArea: cArea.filteredSpecificMealsFromApi[index].strArea ?? "",
                        strInstructions: cArea.filteredSpecificMealsFromApi[index].strInstructions ?? "", strMealThumb: cArea.filteredSpecificMealsFromApi[index].strMealThumb,
                                            isArchived: true)
                                               cArea.filteredSpecificMealsFromApi.remove(at: index)
                                           } label: {
                                               Label("Arkiver", systemImage: "archivebox.fill")
                                           }
                                           .tint(.blue)
                                       }
                                }
                                
        
                            
                        }else if (selection == options[1]){
                           
                            
                            
                            
                            
                           
                            ForEach(cCategory.filteredSpecificMealsFromApi.indices,id: \.self ){ index in
                               
                                MRVSearch(recipe: cCategory.filteredSpecificMealsFromApi[index])
                                .padding(.vertical, 8)
                                       
                                        .swipeActions(edge:.trailing){
                                            Button {
                                                cMeal.addMealRecord(idMeal: cCategory.filteredSpecificMealsFromApi[index].idMeal, strMeal:cCategory.filteredSpecificMealsFromApi[index].strMeal,
                                                                     strCategory: cCategory.filteredSpecificMealsFromApi[index].strCategory ?? "",
                                                                     strArea: cCategory.filteredSpecificMealsFromApi[index].strArea ?? "",
                                                                     strInstructions: cCategory.filteredSpecificMealsFromApi[index].strInstructions ?? "", strMealThumb: cCategory.filteredSpecificMealsFromApi[index].strMealThumb,
                                                                     isArchived: false)
                                                cCategory.filteredSpecificMealsFromApi.remove(at: index)
                                            } label: {
                                                Label("Arkiver", systemImage: "archivebox.fill")
                                            }
                                            .tint(.blue)
                                        }
                                    
                                    
                            
                                
                                }
                        
                        
                        
                        
                     
                       
                
                        }else if(selection == options[2]){
                        
                            
                            
                            ForEach(cIngredient.filteredSpecificMealsFromApi.indices, id: \.self ){ index in
                                MRVSearch(recipe: cIngredient.filteredSpecificMealsFromApi[index])
                               .padding(.vertical, 8)
                                      
                                       .swipeActions(edge:.trailing){
                                           Button {
                                               cMeal.addMealRecord(idMeal: cIngredient.filteredSpecificMealsFromApi[index].idMeal, strMeal:cIngredient.filteredSpecificMealsFromApi[index].strMeal, strCategory: cIngredient.filteredSpecificMealsFromApi[index].strCategory ?? "", strArea: cIngredient.filteredSpecificMealsFromApi[index].strArea ?? "", strInstructions: cIngredient.filteredSpecificMealsFromApi[index].strInstructions ?? "", strMealThumb: cIngredient.filteredSpecificMealsFromApi[index].strMealThumb, isArchived: false)
                                               cIngredient.filteredSpecificMealsFromApi.remove(at: index)
                                           } label: {
                                               Label("Arkiver", systemImage: "archivebox.fill")
                                           }
                                           .tint(.blue)
                                       }
                                }
                                
     
                        }
                            
                        
                    }header: {
                       Text(selection)
                    }
 
            }
                
            }
            .navigationTitle("Søk måltid")
        }
    }
    
}

struct MRVSearch: View {
    var recipe: MMeal

    var body: some View {
        NavigationLink(destination: MDVSearch(recipeDetail: recipe)) {
            HStack {
                AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(5)

                Text(recipe.strMeal)
                    .font(.headline)
                    .padding(.leading, 8)
            }
            .padding(.vertical, 8)
        }
        
    }
}

struct MDVSearch: View {
    var recipeDetail: MMeal

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: recipeDetail.strMealThumb)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(5)

                Text(recipeDetail.strMeal)
                    .font(.headline)
                    .padding(.leading, 8)
            }
            .padding(.vertical, 8)
            Text(recipeDetail.strIngredient1 ?? "")
                .font(.headline)
                .padding(.leading, 8)
            Text(recipeDetail.strIngredient2 ?? "")
                .font(.headline)
                .padding(.leading, 8)
            Text(recipeDetail.strIngredient3 ?? "")
                .font(.headline)
                .padding(.leading, 8)
            Text(recipeDetail.strIngredient4 ?? "")
                .font(.headline)
                .padding(.leading, 8)
            Text(recipeDetail.strInstructions ?? "")
                .font(.headline)
                .padding(.leading, 8)
           
            // Other details of the meal

            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Måltid detaljer"), displayMode: .inline)
     
    }
}


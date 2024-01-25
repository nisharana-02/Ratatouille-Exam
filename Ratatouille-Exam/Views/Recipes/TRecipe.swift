//
//  TRecipe.swift
//  Ratatouille-Exam
//
//
//

import SwiftUI

struct TRecipe: View {
    
    

    
    @StateObject var cMeal = CMeal()
    @State var mealTextFieldName: String = ""
    @State var errorMessage: String = ""
   
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                List{
                    
                    
                    
                    Section{
                        
                        ForEach(cMeal.dbMealRecords.indices,id: \.self ){ index in
                            if(!cMeal.dbMealRecords[index].isArchived){
                                
                         
                                
                                RVMeal(recipe : cMeal.dbMealRecords[index])
                                    .swipeActions(edge:.leading){
                                        
                                        Button {
                                            cMeal.favMealRecord( index: index)
                                        } label: {
                                            Label(cMeal.dbMealRecords[index].isFav ? "Fjern Favoritt" : "Favoritt", systemImage: cMeal.dbMealRecords[index].isFav ? "star.fill" : "star")
                                        }
                                        .tint(cMeal.dbMealRecords[index].isFav ? .yellow : .gray)
                                        
                                    }
                                    .swipeActions(edge:.trailing){
                                        Button {
                                            cMeal.archivedMealRecord( index: index)
                                            cMeal.dbMealRecords.remove(at: index)
                                        } label: {
                                            Label("Arkiver", systemImage: "archivebox.fill")
                                        }
                                        .tint(.blue)
                                    }
                                
                                
                        }
                            
                            }
                      
                        
                    }header: {
                        Text( "Ikke arkiverte måltider")
                        
                    }
                    
     
                       }
                          .listStyle(PlainListStyle())
                
                
            }
            .navigationTitle("Ratatouille")
        
        }
    }
    
}

struct RVMeal: View {
    var recipe: EMeal

    var body: some View {
        NavigationLink(destination: DVMeal(recipeDetail: recipe)) {
            HStack {
                AsyncImage(url: URL(string: recipe.strMealThumb ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(5)

                Text(recipe.strMeal ?? "")
                    .font(.headline)
                    .padding(.leading, 8)
            }
            .padding(.vertical, 8)
        }
        
    }
}

struct DVMeal: View {
    var recipeDetail: EMeal

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: recipeDetail.strMealThumb ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(5)

                Text(recipeDetail.strMeal ?? "")
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
           
           

            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Måltid Detaljer"), displayMode: .inline)
        .navigationBarItems(trailing: NavigationLink(destination: EVMeal(recipe: recipeDetail)) {
            Image(systemName: "pencil.circle.fill")
        })
    }
}

struct EVMeal: View {
    var recipe: EMeal
  
    @State var ingredientTextField1: String = ""
    @State var ingredientTextField2: String = ""
    @State var ingredientTextField3: String = ""
    @State var ingredientTextField4: String = ""
    @State var ingredientTextField5: String = ""
    @State var errorMessage : String = ""
      
   @StateObject var cMeal = CMeal()
    
    var body: some View {
        
       
 
        List{
            Section{
                
                Text( "\(errorMessage) ")
            
                
                TextField("Ingrediens 1...." , text: $ingredientTextField1)
                      .font(.headline)
                      .padding(.leading)
                      .frame(height: 55)
                      .background(Color .white)
                      .cornerRadius(10)
                      .padding(.horizontal)
                  
                TextField("Ingrediens  2...." , text: $ingredientTextField2)
                      .font(.headline)
                      .padding(.leading)
                      .frame(height: 55)
                      .background(Color .white)
                      .cornerRadius(10)
                      .padding(.horizontal)
                  
                TextField("Ingrediens 3...." , text: $ingredientTextField3)
                      .font(.headline)
                      .padding(.leading)
                      .frame(height: 55)
                      .background(Color .white)
                      .cornerRadius(10)
                      .padding(.horizontal)
                  
                TextField("Ingrediens 4...." , text: $ingredientTextField4)
                      .font(.headline)
                      .padding(.leading)
                      .frame(height: 55)
                      .background(Color .white)
                      .cornerRadius(10)
                      .padding(.horizontal)
                  
                TextField("Ingrediens 5...." , text: $ingredientTextField5)
                      .font(.headline)
                      .padding(.leading)
                      .frame(height: 55)
                      .background(Color .white)
                      .cornerRadius(10)
                      .padding(.horizontal)
                
               Button(action :{
                   guard !ingredientTextField1.isEmpty else  {
                       
                      errorMessage = "Måltid ingrediens 1 er nødvendig"
                       return}
                   
                   guard !ingredientTextField2.isEmpty else  {
                       
                      errorMessage = "Måltid ingrediens 2 er nødvendig"
                       return}
                   
                   guard !ingredientTextField3.isEmpty else  {
                       
                      errorMessage = "Måltid ingrediens 3 er nødvendig"
                       return}
                   
                   guard !ingredientTextField4.isEmpty else  {
                       
                      errorMessage = "Måltid ingrediens 4 er nødvendig"
                       return}
                   
                   guard !ingredientTextField5.isEmpty else  {
                       
                      errorMessage = "Måltid ingrediens 5 er nødvendig"
                       return}
                   
                   
                   
                   
                cMeal.updateMealIngredients(
                    idMeal : recipe.idMeal ?? "",
                    strIngredient1 : ingredientTextField1 ,
                    strIngredient2 : ingredientTextField2 ,
                    strIngredient3 : ingredientTextField3 ,
                    strIngredient4 : ingredientTextField4 
                    
                )
                
                }, label: {
                    Text("Knapp")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(.pink))
                        .cornerRadius(10)
                })
                
               .padding(.horizontal)
                
            }header: {
               Text("Rediger ingredienser her")
            }
        }
        .onAppear(perform:{
           
            ingredientTextField1 = recipe.strIngredient1 ?? ""
            ingredientTextField2 = recipe.strIngredient2 ?? ""
            ingredientTextField3 = recipe.strIngredient3 ?? ""
            ingredientTextField4 = recipe.strIngredient4 ?? ""
             
          
            
            
            
            
        } )
    }
}








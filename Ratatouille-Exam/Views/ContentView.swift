//
//  ContentView.swift
//  Ratatouille-Exam
//


import SwiftUI

struct ContentView: View {
    var body: some View {
            ZStack {
               
                Color.blue
                    .ignoresSafeArea()
                Text("Innholdsvisning")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                TabView {
                    TRecipe()
                        .tabItem (){
                        
                           Image(systemName: "fork.knife.circle.fill")
                            Text("Mine oppskrifter")
                            
                        }
                   TSearch()
                          .tabItem (){
                              Image(systemName: "magnifyingglass.circle.fill")
                              Text("Søk")
                          }
                   TSetting()
                           .tabItem (){
                               Image(systemName: "gearshape.circle.fill")
                               Text("Innstillinger")
                           }
                }
            }
        
        }
}

#Preview {
    ContentView()
}

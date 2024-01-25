//
//  SplashScreen.swift
//  Ratatouille-Exam
//
// 
//

import SwiftUI
import UIKit

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        
              
        }else{
            VStack {
                VStack{
                 Image(systemName: "rat.fill")
                        .font(.system(size:80))
                        .foregroundColor(.black)
                    Text("Ratatouille")
                        .font(Font.custom("Baskerville-Bold", size: 40))
                        .foregroundColor(.red.opacity(0.80))
                    }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    withAnimation{
                        self.isActive = true
                    }
                   
                }
              
            }
        }
    }
       
}

#Preview {
    SplashScreen()
}



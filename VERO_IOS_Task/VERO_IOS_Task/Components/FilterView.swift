//
//  FilterView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI


struct FilterView: View {
    @Binding var taskQuery: String
    @Binding var titleQuery: String
    @Binding var descriptionQuery: String
    @Binding var colorQuery: String
    
    var body: some View {
        VStack (spacing: 30) {
            VStack   {
                Button(action: {
                    // Filtreleme işlemleri burada gerçekleştirilebilir
                }) {
                    Text("Filter")
                }
                .frame(width: 150,height: 20)
                .font(.title3)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            HStack(spacing: 10) {
                Text("Task:")
                Spacer()
                TextField("Search...", text: $taskQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: 250)
  }
            
            HStack(spacing: 10) {
                Text("Title:")
                Spacer()
                TextField("Search...", text: $titleQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: 250)
   }
            
            HStack(spacing: 10) {
                Text("Description:")
                Spacer()
                TextField("Search...", text: $descriptionQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()  
                    .frame(maxWidth: 250)

            }
            
            HStack(spacing: 10) {
                Text("Color:")
                Spacer()
                TextField("Search...", text: $colorQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: 250)
  }
        }.padding()
    }
}


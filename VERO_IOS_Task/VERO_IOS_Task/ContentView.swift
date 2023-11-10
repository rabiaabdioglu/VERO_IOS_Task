//
//  ContentView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var listViewModel = ListViewModel()


    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                Text("Welcome")
                    .font(.title)
                
                Text("This app helps you track tasks and access important information. List your tasks, organize them by color codes, and quickly search using the QR code scanner. To get started, simply click the 'Start' button and enjoy the app.")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(10)
                    .font(.caption)
                
                Spacer()
                
                NavigationLink("Start", destination: HomeView())
                    .frame(width: 200,height: 50)
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
            .padding()
        }
    }
        }

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }

    

  

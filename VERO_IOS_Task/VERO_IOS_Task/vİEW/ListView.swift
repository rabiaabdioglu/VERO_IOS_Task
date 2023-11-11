//
//  ListView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

struct ListView: View {
    // Search text for the list
    @State  var searchText = ""
    @Binding var searchTextForQR: String

    // ListViewModel to manage data
    @StateObject private var listViewModel = ListViewModel()

    
    var filteredTasks: [Task] {
         let lowercasedSearchText: String
         if searchTextForQR.isEmpty {
             lowercasedSearchText = searchText.lowercased()
         } else {
             lowercasedSearchText = searchTextForQR.lowercased()
         }
         
         guard !lowercasedSearchText.isEmpty else { return listViewModel.tasks }

      
        print(lowercasedSearchText)


     

          return listViewModel.tasks.filter { task in
              let propertiesToSearch: [String?] = [
                  task.task, task.title, task.taskDescription, task.sort,
                  task.wageType, task.businessUnitKey, task.businessUnit,
                  task.parentTaskID, task.preplanningBoardQuickSelect, task.colorCode,
                  task.workingTime, String(task.isAvailableInTimeTrackingKioskMode)
              ]

              return propertiesToSearch.compactMap { $0?.lowercased() }.contains { $0.contains(lowercasedSearchText) }
          }
      }
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                Text("Total Tasks: \(filteredTasks.count)")
                    .font(.footnote)
                ForEach(filteredTasks, id: \.id) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskCellView(task: task)
                    }
                }
            }
            
            .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                         Button(action: {
                             // Burada searchTextForQR "" olmalı
                             searchText = ""
                             searchTextForQR = ""
                         }) {
                             Text("Clean Filter")
                         }
                     }
                 }

        }
        .font(.custom("SFPro-Regular", size: 15))
        .foregroundColor(.customText)
        .refreshable {
            // Refresh the task list
            searchText = ""
            searchTextForQR = ""
            listViewModel.fetchTasks()
        }
        
        .searchable(text: $searchText, prompt: "Search Task")  // Add search functionality to the list
     
        
        
    }
}


//
//  ListView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

struct ListView: View {
    // Search text for the list
    @State private var searchText = ""
    @State private var searchQuery = ""
    
    // State to control the filter sheet presentation
    @State private var isFilterSheetPresented = false
    
    // ListViewModel to manage data
    @StateObject private var listViewModel = ListViewModel()

    
    var filteredTasks : [Task] {
        guard  !searchText.isEmpty else {return listViewModel.tasks}
        return listViewModel.tasks.filter{$0.task.localizedCaseInsensitiveContains(searchText)}
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTasks, id: \.id) { task in
                     NavigationLink(destination: TaskDetailView(task: task)) {
                         TaskCellView(task: task)
                     }
                 }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Button to show the filter sheet
                    Button(action: {
                        isFilterSheetPresented.toggle()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $isFilterSheetPresented) {
                // FilterView for filtering tasks
                FilterView(taskQuery: $searchQuery, titleQuery: $searchQuery, descriptionQuery: $searchQuery, colorQuery: $searchQuery)
            }
        }
        .navigationBarBackButtonHidden(true)
        .refreshable {
            // Refresh the task list
            listViewModel.fetchTasks()
        }
        .searchable(text: $searchText, prompt: "Search Task")  // Add search functionality to the list
    }
}

// Preview the ListView
#Preview {
    ListView()
}

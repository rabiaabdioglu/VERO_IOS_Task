//
//  TaskDetail.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

struct TaskDetailView: View {
    
    var task: Task!

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {                
            Spacer()
            Spacer()
            HStack {
                Text(task.task)
                    .font(.title)
                    .padding(.trailing, 10)
                Spacer()
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(hex: task.colorCode))
                    .padding(.trailing)
            }        .padding(10)
            
            Divider()

            VStack(alignment: .leading, spacing: 40) {

                Text(task.title)
                    .font(.title2)

                Text(task.taskDescription  ?? "  ")
                    .font(.caption)
            }
            .padding(10)
            Divider()

            HStack(spacing: 40) {

                Text(task.businessUnit)
                    .font(.caption2)
                Spacer()
                Text(task.parentTaskID)
                    .font(.caption2)
            }
            .padding(10)
      

        }
        .frame(maxHeight: 120)
        .foregroundColor(.customText)
        .padding(10)
        Spacer()
    }
    
}

#Preview {
    TaskDetailView()
}

//
//  TaskDetail.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

struct TaskDetailView: View {
    
    var task: Task!
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Spacer()
            
            HStack {
                Text(task.task)
                    .font(.title)
                    .padding(.trailing, 10)
                Spacer()
                VStack{  Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(hex: task.colorCode))
                        .padding(.trailing)
                    Text(task.colorCode)
                        .font(.caption2)
                        .fontWeight(.ultraLight)
                }
            }
            .padding(10)
            Divider()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading){
                    Text("Title")
                        .font(.footnote)
                        .fontWeight(.ultraLight)
                    
                    Text(task.title)
                        .font(.title2)
                }
                VStack(alignment: .leading){
                    Text("Description")
                        .font(.footnote)
                        .fontWeight(.ultraLight)
                    
                    Text(task.taskDescription  ?? "  ")
                        .font(.caption)
                }
            }
            .padding(10)
            Divider()
            
            HStack(spacing: 20) {
                Text("Business Unit")
                    .font(.footnote)
                    .fontWeight(.ultraLight)
                Text(task.businessUnit)
                    .font(.caption2)
                
                Spacer()
                Text("Parent Task")
                    .font(.footnote)
                    .fontWeight(.ultraLight)
                Text(task.parentTaskID.isEmpty ? "-" : task.parentTaskID)
                    .font(.caption2)
            }
            .padding(10)
            
            Spacer()
        }
        .font(.custom("SFPro-Regular", size: 15))
        .frame(maxHeight: .infinity)
        .foregroundColor(.customText)
        .padding(10)
        .toolbar {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    TaskDetailView()
}

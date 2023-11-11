//
//  TaskCellView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

struct TaskCellView: View {
    
     var task: Task!

    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(task.task)
                    .font(.title3)
                    .padding(.trailing, 10)
                Spacer()
                VStack{  Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(hex: task.colorCode))
                        .padding(.trailing)
                    Text(task.colorCode)
                        .font(.caption2)
                        .fontWeight(.ultraLight)
                    
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {

                Text(task.title)
                    .font(.caption)
                Text(task.taskDescription!)
                    .font(.caption2)
            }
            .padding(10)

        }     
        .font(.custom("SFPro-Regular", size: 15))
        .frame(maxHeight: 120)
        .foregroundColor(.customText)
        .padding(10)
       
    }
}




#Preview {
    TaskCellView()
}

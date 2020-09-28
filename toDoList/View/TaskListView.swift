//
//  TaskListView.swift
//  toDoList
//
//  Created by 김종원 on 2020/09/28.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(taskListViewModel.taskCellViewModels) { taskCellViewModel in
                        TaskCell(taskCellViewModel: taskCellViewModel)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellViewModel: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListViewModel.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add New Task")
                    }
                }
                .padding()
            }
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: taskCellViewModel.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
            TextField("Enter the task title", text: $taskCellViewModel.task.title, onCommit: {
                self.onCommit(self.taskCellViewModel.task)
            })
        }
    }
}

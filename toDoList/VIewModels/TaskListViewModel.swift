//
//  TaskListViewModel.swift
//  toDoList
//
//  Created by 김종원 on 2020/09/28.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.taskCellViewModels = testDataTasks.map { task in
            TaskCellViewModel(task: task)
        }
    }
    
    func addTask(task: Task) {
        let taskViewModel = TaskCellViewModel(task: task)
        self.taskCellViewModels.append(taskViewModel)
    }
}

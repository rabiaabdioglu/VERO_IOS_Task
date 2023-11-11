//  ListViewModel.swift

import Foundation
import Combine
import CoreData

class ListViewModel: ObservableObject {
    // Published properties for data binding
    @Published var tasks: [Task] = []
    
    // Cancellable set to manage Combine subscriptions
    private var cancellables: Set<AnyCancellable> = []
    
    // Network service for API communication
    private var networkService = NetworkService()
    
    // Core Data container for local storage
    let container: NSPersistentContainer
    

    
    init() {
        // Core Data container initialization
        container = NSPersistentContainer(name: "VERO_IOS_Task")

        // Load persistent stores
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load data in DataController \(error.localizedDescription)")
            }
        }


        // Authenticate with your username and password to get the access token.
        networkService.authenticate(username: "365", password: "1")
            .receive(on: DispatchQueue.main)  // Ana thread üzerinde çalışmasını sağlar

            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.fetchTasks()
                case .failure(let error):
                    print("Authorization error: \(error.localizedDescription)")
                    self.getTasksFromCoreData()
                }
            }, receiveValue: {})
            .store(in: &cancellables)
    }
    
    
    // Fetch tasks from the network
    func fetchTasks() {
        tasks = []
        networkService.fetchTasks()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Fetching tasks error: \(error.localizedDescription)")
                }
            }, receiveValue: { tasks in
                for task in tasks {
                    var taskWithID = task
                    taskWithID.id = UUID()
//                 print(taskWithID)
                    self.tasks.append(taskWithID)
                    self.saveTaskToCoreData(task: taskWithID)
                }
            })
            .store(in: &cancellables)
    }
    
    // Fetch tasks from Core Data
    private func getTasksFromCoreData() {
        let context = container.viewContext
        do {
            let cdTasks = try context.fetch(CDTask.fetchRequest()) as! [CDTask]
            self.tasks = cdTasks.map { task in
                Task(
                    id: task.id ?? UUID(),
                    task: task.task ?? "",
                    title: task.title ?? "",
                    taskDescription: task.taskDescription,
                    sort: task.sort ?? "",
                    wageType: task.wageType ?? "",
                    businessUnitKey: task.businessUnitKey,
                    businessUnit: task.businessUnit ?? "",
                    parentTaskID: task.parentTaskID ?? "",
                    preplanningBoardQuickSelect: task.preplanningBoardQuickSelect,
                    colorCode: task.colorCode ?? "",
                    workingTime: task.workingTime,
                    isAvailableInTimeTrackingKioskMode: task.isAvailableInTimeTrackingKioskMode
                )
            }
        } catch {
            print("Failed to fetch tasks from Core Data: \(error.localizedDescription)")
        }
    }

    // Save task to Core Data
    private func saveTaskToCoreData(task: Task) {
        let context = container.viewContext

        let fetchRequest: NSFetchRequest<CDTask> = CDTask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "task == %@", task.task )

        do {
            if let existingCDTask = try context.fetch(fetchRequest).first {
                existingCDTask.update(with: task)
//                print(existingCDTask)
//                print("___________________________________________________")
            } else {
                let cdTask = CDTask(context: context)
                cdTask.update(with: task)
            }
            
            try context.save()
        } catch {
            print("Failed to save task to Core Data: \(error.localizedDescription)")
        }
    }
}

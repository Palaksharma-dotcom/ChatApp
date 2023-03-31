//
//  Persistence.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    init() {
        container = NSPersistentContainer(name: "ChatBot")
        context = container.viewContext
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    func save() {
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    func saveQuestion(question: String, id: UUID,parent: UUID?) {
        let user = Questions(context: self.context)
//        Questions -> Entity name
        
        user.id = id
        user.parent = parent
        user.question = question
        save()
    }
    
}
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

   

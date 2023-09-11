//
//  Item.swift
//  MachineTask
//
//  Created by Apple  on 11/09/23.
//

import Foundation

struct Item {
    var id: UUID
    var name: String
    var photo:Data
}

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

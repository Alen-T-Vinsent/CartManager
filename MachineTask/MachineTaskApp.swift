
import SwiftUI

@main
struct MachineTaskApp: App {
    @StateObject private var dataController = DataController()
    @StateObject var userVm = UserViewModel()
    var body: some Scene {
        WindowGroup {
          ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(userVm)
                
        }
    }
}

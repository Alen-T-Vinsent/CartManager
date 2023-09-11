import SwiftUI

struct ContentView: View {
    @AppStorage("LOGIN_STATUS") var LOGIN_STATUS:Bool = false
    
    @StateObject private var dataController = DataController()
    
    var body: some View {
        if LOGIN_STATUS{
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }else{
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

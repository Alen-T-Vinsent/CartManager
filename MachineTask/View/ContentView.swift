import SwiftUI

struct ContentView: View {
    @AppStorage("LOGIN_STATUS") var LOGIN_STATUS:Bool = false
    
  
    
    var body: some View {
        if LOGIN_STATUS{
            HomeView()
                
        }else{
            LoginView()
        }
    }
}

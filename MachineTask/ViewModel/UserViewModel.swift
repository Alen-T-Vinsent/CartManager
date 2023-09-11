import SwiftUI

class UserViewModel:ObservableObject{
    @AppStorage("LOGIN_STATUS") var LOGIN_STATUS:Bool = false
    
    //MARK: - For Login View
    @Published var emailTxt:String = ""
    @Published var passwordTxt:String = ""
    @Published var showPassword:Bool = true
    
    
    //MARK: - Alert
    @Published var showAlert:Bool = false
    @Published var isLoggedIn:Bool = false
    
    @Published var cartItems:[CartModel] = [CartModel]()
    

    func login() {
           guard let url = URL(string: "https://reqres.in/api/login") else { return }
           
           let parameters: [String: String] = ["email": emailTxt, "password": passwordTxt]
           let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.httpBody = jsonData
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               guard let data = data, error == nil else {
                   print("Error: \(error?.localizedDescription ?? "Unknown error")")
                   return
               }
               
               if let httpResponse = response as? HTTPURLResponse {
                   if httpResponse.statusCode == 200 {
                       //login success
                       DispatchQueue.main.async {
                           self.isLoggedIn = true
                           self.showAlert = true
                       }
                   } else {
                       DispatchQueue.main.async {
                           self.isLoggedIn = false
                           self.showAlert = true
                          
                       }
                   }
               }
           }.resume()
       }
}



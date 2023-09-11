//
//  UserViewModel.swift
//  ListGenius
//
//  Created by Apple  on 11/09/23.
//

import SwiftUI

class UserViewModel:ObservableObject{
    @AppStorage("LOGIN_STATUS") var LOGIN_STATUS:Bool = false
    
    //For Login View
    @Published var emailTxt:String = "eve.holt@reqres.in"
    @Published var passwordTxt:String = "cityslicka"
    @Published var showPassword:Bool = true
    
    
   // @Published var paginationData:[PaginationData] = []
    
    //Alert
    @Published var showAlert:Bool = false
    @Published var alertMessage:String = ""
    @Published var alertTitle:String = ""
    @Published var isLoggedIn:Bool = false

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
    
//
//    func fetchPaginationData(completion: @escaping (Bool) -> Void) {
//        let loginApi = "https://reqres.in/api/login"
//        WebService.shared.downloadData(fromURL: loginApi) { (response: PaginationData?, error) in
//            if let _ = response {
//                print("Successfully fetched Pagination Data")
//                self.paginationData.append(response!)
//                completion(true)
//            } else if let _ = error {
//                print("Error in fetching Pagination Data")
//                completion(false)
//            }
//        }
//    }

    
    
}

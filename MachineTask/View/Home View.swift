//
//  HomeView.swift
//  ListGenius
//
//  Created by Apple  on 11/09/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("LOGIN_STATUS") var LOGIN_STATUS:Bool = false
    
    @State var showAddItemSheet = false
    

    
    var body: some View {
        VStack{
            Text("Add item")
                .onTapGesture {
                   showAddItemSheet = true
                }
           Text("Je;;p")
                .onTapGesture {
                    LOGIN_STATUS = false
                }
            
            ScrollView{
                ForEach(1...10,id:\.self){each in
                    CardView()
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            
            
        }
        .sheet(isPresented: $showAddItemSheet) {
            AddItemView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

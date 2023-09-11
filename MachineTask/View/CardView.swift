//
//  CardView.swift
//  MachineTask
//
//  Created by Apple  on 11/09/23.
//

import SwiftUI

struct CardView: View {
    @State var showStepper:Bool = false
    @State private var quantity = 0
    
    var body: some View {
        VStack{
                Text("Alen")
                    .hAlign(.leading)
                    .font(.title)
                Text("Batch number")
                    .hAlign(.leading)
                    .onTapGesture {
                        withAnimation {
                            showStepper.toggle()
                        }
                    }
            
            //Stepper and button

            VStack {
                       if showStepper {
                           HStack{
                               Stepper("Quantity: \(quantity)", value: $quantity, in: 0...10)
                           }
                              
                               .frame(maxWidth: UIScreen.main.bounds.width/2,maxHeight:20)
                               .padding(15)
                                .foregroundColor(.white)
                                .background(.orange)
                                .cornerRadius(10)
                           
                       } else {
                           Button(action: {
                               withAnimation {
                                   showStepper.toggle()
                               }
                               
                           }){
                            Text("Buy Item")
                                   .frame(maxWidth: UIScreen.main.bounds.width/2)
                                   .padding(15)
                                    .foregroundColor(.white)
                                    .background(.orange)
                                    .cornerRadius(10)
                                }
                       }
                
                
                Button(action: {
                    withAnimation {
                        showStepper.toggle()
                    }
                    
                }){
                 Text("Add to cart")
                        .frame(maxWidth: UIScreen.main.bounds.width/2)
                        .padding(15)
                         .foregroundColor(.white)
                         .background(.orange)
                         .cornerRadius(10)
                     }
                
                
                   }
            .hAlign(.center)

            
            
            
        }
        .padding()
        .background(.red)
        
        
       
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

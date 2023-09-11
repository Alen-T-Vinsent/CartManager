
import SwiftUI

struct CardView: View {
    @EnvironmentObject var userVm:UserViewModel
    
    @State var showStepper:Bool = false
    @State private var quantity = 0
    
    var data:ItemEntity
    
    //Propeties
    var name:String
    var batchId:String
    var image:Data
    
    var gradient = LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.cyan,Color.purple, Color.purple]), startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        VStack{
            HStack{
                Image(uiImage: UIImage(data: image ) ?? UIImage())
                    .resizable()
                    .frame(maxWidth: UIScreen.main.bounds.width/4,maxHeight:UIScreen.main.bounds.width/4)
                    .cornerRadius(20)
                
                
                VStack{
                    
                    Text(name)
                        .hAlign(.leading).hAlign(.leading)
                        .font(.title.bold())
                    
                    Text(batchId)
                        .hAlign(.leading)
                    
                        .onTapGesture {
                            withAnimation {
                                showStepper.toggle()
                            }
                        }
                }
 
            }
            
            //Stepper and button
            HStack {
                if showStepper {
                    HStack{
                        Stepper("\(quantity)", value: $quantity, in: 0...20)
                    }
                    
                    .frame(maxWidth: UIScreen.main.bounds.width/2,maxHeight:20)
                    .padding(15)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                } else {
                    Button(action: {
                        withAnimation {
                            showStepper = true
                        }
                        
                    }){
                        Text("Buy Item")
                            .frame(maxWidth: UIScreen.main.bounds.width/2)
                            .padding(15)
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
                
                
                Button(action: {
                    if quantity > 0 {
                        let newCartItem = CartModel(name: name, count: quantity)
                        userVm.cartItems.append(newCartItem)
                        quantity = 0
                        showStepper = false
                        
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
        .background(.gray)
    }
    
}


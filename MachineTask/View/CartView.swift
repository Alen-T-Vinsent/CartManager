
import SwiftUI

struct CartView: View {
    @EnvironmentObject var userVm:UserViewModel
    var body: some View {
        List(userVm.cartItems,id:\.id){ cartItem in
            VStack{
                HStack{
                   Text("Item name")
                    Spacer()
                    Text(cartItem.name)
                }
                HStack{
                   Text("Item count")
                    Spacer()
                    Text("\(cartItem.count)" as String)
                }
               
            }
        }
    }
}

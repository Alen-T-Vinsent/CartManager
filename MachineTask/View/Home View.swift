
import SwiftUI

struct HomeView: View {
    @AppStorage("LOGIN_STATUS") var LOGIN_STATUS:Bool = false
    
    @State var showAddItemSheet = false
    @State var showCartSheet = false
    
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<ItemEntity>

    
    var body: some View {
        VStack{
            HStack{
                Spacer()
               Text("logout")
                    .onTapGesture {
                        LOGIN_STATUS = false
                    }
                Image(systemName: "cart.fill")
                    .onTapGesture {
                        showCartSheet = true
                    }
                    .padding()
            }
            
            ScrollView{
                ForEach(items,id:\.id){ item in
                    CardView(data: item, name: item.nameAttribute ?? "UNKNOWN", batchId: item.batchNoAttribute ?? "UNKNOWN", image: item.imageAttribute ?? Data())
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            
            
        }
        .overlay(alignment:.bottomTrailing){
            
            Button {
                print("showAddItemSheet ")
                showAddItemSheet = true
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .padding()
            }
        }
        .sheet(isPresented: $showAddItemSheet) {
            AddItemView()
        }
        .sheet(isPresented: $showCartSheet) {
            CartView()
        }
    }
}


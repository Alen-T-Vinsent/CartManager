//
//  register.swift
//  LoveElixir
//
//  Created by Apple  on 05/09/23.
//

import SwiftUI
import PhotosUI


struct AddItemView:View{
    
    //MARK: Properties
    @State var name:String = ""
    @State var batchNumber:String = ""
    
    //MARK: Userdetails
    @State var userProfilePicData:Data?
    //MARK: ViewProperties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker:Bool = false
    @State var photoItem:PhotosPickerItem?
  

    var body: some View{
        VStack(spacing:10){
            Text("Add new item")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
        
            //MARK: for small size optimization
            ViewThatFits{
                ScrollView(.vertical,showsIndicators: false) {
                    HelperView()
                }
                HelperView()
            }
            
 
        }
        .vAlign(.top)
        .padding(15)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            //MARK: extracting uiimage from PhotoItem
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                        
                        //MARK: updating ui on main thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
    }
    
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing:12){
            ZStack{
                if let userProfilePicData,let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                }
            }
            .frame(width: 85,height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top,25)
            
            
            TextField("enter your name", text: $name)
                .border(1, .gray.opacity(0.5))
                .textContentType(.emailAddress)
                .padding(.top,25)
                .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
            TextField("enter your batch number", text: $batchNumber)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
                .disableAutocorrection(true)
                            .autocapitalization(.none)

            
            Button {
                print("Add item btn tapped")

                guard let userPic = userProfilePicData else{
                    return
                }
                
                print(type(of: userPic))

            } label: {
                //MARK: login button
                Text("Add Item")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(name == "" ||  batchNumber == "" || userProfilePicData == nil)
            .padding(.top,10)
            
        }
    }
    
    
}



//MARK: View extension for UIBuilding
extension View{
    
    //Closing all active keyboards
    func closeKeyboard(){///when signin or signup pressed active keyboard is closed
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //MARK: Disabling with opacity
    func disableWithOpacity(_ condition:Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ alignment:Alignment)->some View{
        self
            .frame(maxWidth: .infinity,alignment: alignment)
    }
    
    func vAlign(_ alignment:Alignment)->some View{
        self
            .frame(maxHeight: .infinity,alignment: alignment)
    }
    
    //MARK: Custom border view with padding
    func border(_ width:CGFloat,_ color:Color)->some View{
        self
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background{ RoundedRectangle(cornerRadius: 5,style: .continuous)
                .stroke(color,lineWidth: width)
                
            }
    }
    
    //MARK: Custom fill view with padding
    func fillView(_ color:Color)->some View{
        self
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background{ RoundedRectangle(cornerRadius: 5,style: .continuous)
                .fill(color)
                
            }
    }

}



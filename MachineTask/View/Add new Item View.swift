
import SwiftUI
import PhotosUI
import CoreData

struct AddItemView:View{
    
    //MARK: Properties
    @State var name:String = ""
    @State var batchNumber:String = ""
    @State var image:Data?
    
    //MARK: ViewProperties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker:Bool = false
    @State var photoItem:PhotosPickerItem?
    
    //MARK: CoreData
    @Environment(\.managedObjectContext) var moc
    
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
                            image = imageData
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
                if let image,let image = UIImage(data: image){
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
            
            //MARK: Name Textfield
            TextField("enter your name", text: $name)
                .border(1, .gray.opacity(0.5))
                .textContentType(.emailAddress)
                .padding(.top,25)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            //MARK: Batch Texfield
            TextField("enter your batch number", text: $batchNumber)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            //MARK: Add Item
            Button {
                print("Add item btn tapped")
                
                guard let imageData = image else{
                    return
                }
                
                createItem()
                print(type(of: imageData))
                
            } label: {
                Text("Add Item")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(name == "" ||  batchNumber == "" || image == nil)
            .padding(.top,10)
        }
    }
    
    func createItem(){
        let item = ItemEntity(context: moc)
        
        item.batchNoAttribute = batchNumber
        item.imageAttribute = image
        item.nameAttribute = name
        
        do {
            try moc.save()
            print("savedSuccess")
            dismiss()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
}




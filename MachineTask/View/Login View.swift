
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userVm:UserViewModel
    
    var gradient = LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.cyan,Color.purple, Color.purple]), startPoint: .leading, endPoint: .trailing)
    var body: some View {
        VStack(spacing:40){
            Image(systemName: "mic")
                .resizable()
                .frame(maxWidth: 50,maxHeight: 50)
            
            
            VStack{
                Text("SIGN IN")
                Text("TO CONTINUE")
            }
            .bold()
            
            VStack{
                HStack {
                    TextField("Email", text: $userVm.emailTxt)
                }
                .textFieldStyle(OvalTextFieldStyle())
                HStack {
                    if userVm.showPassword {
                        TextField("Password", text: $userVm.passwordTxt)
                    }else{
                        SecureField("Password", text: $userVm.passwordTxt)
                    }
                }
                .textFieldStyle(OvalTextFieldStyle())
                .overlay(alignment:.trailing){
                    Image(systemName: userVm.showPassword ? "eye" : "eye.slash.fill")
                        .resizable()
                        .frame(maxWidth: 20,maxHeight:15)
                        .padding(.trailing)
                        .foregroundColor(.black.opacity(0.8))
                        .onTapGesture {
                            userVm.showPassword.toggle()
                        }
                }
            }
            .padding()
            
            VStack(spacing:5){
                Button {
                    print("login button tapped")
                    userVm.login()
                } label: {
                    Text("Log in")
                        .font(.title3)
                        .frame(height: 50)
                        .frame(maxWidth: UIScreen.main.bounds.width/2)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 50, style: .continuous)
                                .fill(gradient)
                        )
                }
                
                Button{
                    print("forgot password")
                }label: {
                    Text("Lost Password?")
                        .font(.subheadline)
                    
                }
                .foregroundColor(.black)
            }
        }
        .actionSheet(isPresented: $userVm.showAlert) {
            ActionSheet(
                title: Text(userVm.isLoggedIn ? "Login Success" : "Login Failed"),
                message: Text(userVm.isLoggedIn ? "Successfully logged in" : "Please check credentials"),
                buttons: [
                    .default(
                        Text("Ok"),
                        action: {
                            if userVm.isLoggedIn {
                                userVm.LOGIN_STATUS = true
                            } else {
                                userVm.showAlert = false
                            }
                        }
                    ),
                    
                ]
            )
        }
        
    }
}

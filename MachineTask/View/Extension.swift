import SwiftUI

//MARK: View extension for UIBuilding
extension View{
        
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



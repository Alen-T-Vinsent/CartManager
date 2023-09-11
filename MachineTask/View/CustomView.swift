//
//  CustomView.swift
//  MachineTask
//
//  Created by Apple  on 11/09/23.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors:[.gray.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .white, radius: 1)
    }
}

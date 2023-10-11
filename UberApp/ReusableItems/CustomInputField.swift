//
//  CustomInputField.swift
//  UberApp
//
//  Created by Volkan Celik on 19/08/2023.
//

import SwiftUI

struct CustomInputField: View {
    
    @Binding var text:String
    let title:String
    let placeholder:String
    var isSecureField=false
    
    var body: some View {
        VStack(alignment:.leading,spacing:12){
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)

            }else{
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }

            Rectangle()
                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                .frame(width:UIScreen.main.bounds.width-32,height: 0.7)
        }
    }
}

#Preview {
    CustomInputField(text: .constant(""), title: "Email", placeholder: "name@example.com")
}

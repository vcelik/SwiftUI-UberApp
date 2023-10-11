//
//  SettingsRowView.swift
//  UberApp
//
//  Created by Volkan Celik on 21/08/2023.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName:String
    let title:String
    let tintColor:Color
    
    var body: some View {
        HStack(spacing:12){
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(Color.theme
                    .primaryTextColor)
        }
        .padding(4)
    }
}

#Preview {
    SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
}

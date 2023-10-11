//
//  SideMenu.swift
//  UberApp
//
//  Created by Volkan Celik on 21/08/2023.
//

import SwiftUI
import Firebase

struct SideMenu: View {
    
    private let user:User
    
    init(user:User){
        self.user=user
    }
    
    var body: some View {
        VStack(spacing:40){
            //headerview
            VStack(alignment:.leading,spacing:32){
                //user info
                HStack{
                    Image("volkancelik")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                    
                    VStack(alignment:.leading,spacing: 8){
                        Text(user.fullname)
                            .font(.system(size: 16,weight: .semibold))
                        Text(user.email)
                            .font(.system(size: 14))
                            .accentColor(Color.theme.primaryTextColor)
                            .opacity(0.77)
                    }
                }
                
                //become a driver
                
                VStack(alignment:.leading,spacing:16) {
                    Text("Do more with your account")
                        .font(.footnote)
                    .fontWeight(.semibold)
                    
                    HStack{
                        Image(systemName: "dollarsign.square")
                            .font(.title2)
                            .imageScale(.medium)
                        Text("Make Money Driving")
                            .font(.system(size: 16,weight: .semibold))
                            .padding(6)
                    }
                }
                
                Rectangle()
                    .frame(width: 296, height: 0.75)
                    .opacity(0.7)
                    .foregroundColor(Color(.separator))
                    .shadow(color:.black.opacity(0.7),radius: 4)
                    //.padding(.top)
                //option list
            }
            .frame(maxWidth: .infinity,alignment:.leading)
            .padding(.leading,16)
            
            //Spacer()
            
            VStack {
                ForEach(SideMenuOptionViewModel.allCases) { option in
                    NavigationLink(value: option) {
                        SideMenuOptionView(viewModel: option)
                            .padding()
                    }

                }
            }
            .navigationDestination(for: SideMenuOptionViewModel.self) { option in
                switch option{
                case .trips:
                    Text("Trips")
                case .wallet:
                    Text("Wallet")
                case .settings:
                    SettingsView(user: user)
                case .messages:
                    Text("Messages")
                }
            }
            
            Spacer()

        }
        .padding(.top,32)
    }
}

#Preview {
    NavigationStack {
        SideMenu(user: User(
            fullname: "Volkan Çelik",
            email: "celikvolkan85@gmail.com",
            uid: NSUUID().uuidString,
            coordinates: GeoPoint(latitude: 37.38, longitude: -122.05),
            accountType: .passenger,
            homeLocation: nil,
            workLocation: nil))
    }
}

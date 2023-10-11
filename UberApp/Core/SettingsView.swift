//
//  SettingsView.swift
//  UberApp
//
//  Created by Volkan Celik on 21/08/2023.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    
    private let user:User
    @EnvironmentObject var viewModel:AuthViewModel
    
    init(user:User){
        self.user=user
    }
    
    var body: some View {
        VStack{
            List{
                Section{
                    //user info header
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
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                }
                
                Section("Favorites"){
                    ForEach(SavedLocationViewModel.allCases){viewModel in
                        NavigationLink {
                            SavedLocationSearchView(config: viewModel)
                        } label: {
                            SavedLocationRowView(viewModel: viewModel,user: user)
                        }

                    }
                }
                
                Section("Settings"){
                    SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
                    SettingsRowView(imageName: "creditcard.circle.fill", title: "Payment Methods", tintColor: Color(.systemBlue))
                }
                
                Section("Account"){
                    SettingsRowView(imageName: "dollarsign.circle.fill", title: "Make money driving", tintColor: Color(.systemGreen))
                    SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: Color(.systemRed))
                        .onTapGesture {
                            viewModel.signout()
                        }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView(user: User(
            fullname: "Volkan Çelik",
            email: "celikvolkan85@gmail.com",
            uid: NSUUID().uuidString,
            coordinates: GeoPoint(latitude: 37.38, longitude: -122.05),
            accountType: .passenger,
            homeLocation: nil,
            workLocation: nil))
    }
}

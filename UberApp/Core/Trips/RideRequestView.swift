//
//  RideRequestView.swift
//  UberApp
//
//  Created by Volkan Celik on 18/08/2023.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType:RideType = .uberX
    @EnvironmentObject var homeViewModel:HomeViewModel
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48,height: 6)
                .padding(.top,8)
            
            //trip info view
            HStack {
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width:8,height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width:1,height: 32)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width:8,height: 8)
                }
                VStack(alignment:.leading,spacing: 24){
                    HStack{
                        Text("Current Location")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                        Text(homeViewModel.pickupTime ?? "")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom,10)
                    
                    HStack{
                        if let location=homeViewModel.selectedUberLocation{
                            Text(location.title)
                                .font(.system(size: 16,weight: .semibold))
                        }
                        Spacer()
                        Text(homeViewModel.dropOffTime ?? "")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }

                }
                .padding(.leading,8)

            }
            .padding()
            
            Divider()
            //ride type selection view
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing:12){
                    ForEach(RideType.allCases){type in
                        VStack(alignment:.leading){
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            VStack(alignment:.leading,spacing:4){
                                Text(type.description)
                                    .font(.system(size: 14,weight: .semibold))
                                Text(homeViewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            .padding()

                        }
                        .frame(width:112,height: 140)
                        .foregroundColor(type == selectedRideType ? .white : .black)
                        .background(type == selectedRideType ? .blue : .black)

                        .scaleEffect(type == selectedRideType ? 1.2 : 1.00)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType=type
                            }
                        }


                    }
                }
            }
            .padding(.horizontal)

            
            Divider()
                .padding(.vertical,8)
            
            //payment option view
            HStack(spacing:12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height:50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            
            //request ride button
            
            Button {
                homeViewModel.requestTrip()
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width:UIScreen.main.bounds.width-32,height:50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            
            
        }
        .padding(.bottom,24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
    }
}

#Preview {
    RideRequestView()
}






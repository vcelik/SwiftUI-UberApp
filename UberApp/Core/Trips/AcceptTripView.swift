//
//  AcceptTripView.swift
//  UberApp
//
//  Created by Volkan Celik on 23/08/2023.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {
    
    @State private var region:MKCoordinateRegion
    let trip:Trip
    let annotationItem:UberLocation
    @EnvironmentObject var viewModel:HomeViewModel
    
    init(trip:Trip){
        let center=CLLocationCoordinate2D(latitude: trip.pickupLocatipn.latitude, longitude: trip.pickupLocatipn.longitude)
        let span=MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        self.region=MKCoordinateRegion(center: center, span: span)
        self.trip=trip
        self.annotationItem=UberLocation(title: trip.pickupLocationName, coordinate: trip.pickupLocatipn.toCoordinate())
    }
    
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48,height: 6)
                .padding(.top,8)
            //would you like to pickup view
            VStack{
                HStack{
                    Text("Would you like to pickup this passenger?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)
                    
                    Spacer()
                    
                    VStack{
                        Text("\(trip.travelTimeToPassenger)")
                            .bold()
                        Text("min")
                            .bold()
                    }
                    .frame(width: 56, height: 56)
                    .foregroundColor(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
                .padding()
                
                Divider()
            }
            
            //user info view
            VStack{
                HStack{
                    Image("volkancelik")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment:.leading,spacing:4){
                        Text(trip.passengerName)
                            .fontWeight(.bold)
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(.systemYellow))
                                .imageScale(.small)
                            Text("4.8")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing:6){
                        Text("Earnings")
                        
                        Text(trip.tripCost.toCurrency())
                            .font(.system(size: 24,weight: .semibold))
                    }
                    
                    
                }
                Divider()
            }
            .padding()
            
            
            //pickup location info view
            VStack{
                //trip location info
                HStack{
                    //address info
                    VStack(alignment:.leading,spacing:6){
                        Text(trip.pickupLocationName)
                            .font(.headline)
                        Text(trip.pickupLocationAddress)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    //distance info
                    VStack{
                        Text(trip.distanceToPassenger.distanceInMilesString() ?? "0")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("mi")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                //map
                
                Map(coordinateRegion: $region,annotationItems:[annotationItem]){item in
                    MapMarker(coordinate: item.coordinate)
                }
                .frame(height: 220)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.6), radius: 10)
                .padding()

                //divider
                Divider()
            }
            
            //action buttons
            
            HStack{
                Button {
                    viewModel.rejectTrip()
                } label: {
                    Text("Reject")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2)-32, height: 56)
                        .background(Color(.systemRed))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    viewModel.acceptTrip()
                } label: {
                    Text("Accept")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2)-32, height: 56)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }

            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom,24)
        }
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    AcceptTripView(trip: Trip(
        passengerUid: NSUUID().uuidString,
        driverUid: NSUUID().uuidString,
        passengerName: "Volkan Çelik",
        driverName: "John Doe",
        passengerLocation: .init(latitude: 37.123, longitude: -122.1),
        driverLocation: .init(latitude: 37.123, longitude: -122.1),
        pickupLocationName: "Apple Campus",
        dropoffLocationName: "Starbucks",
        pickupLocationAddress: "123 Main St,Palo Alto CA",
        pickupLocatipn: .init(latitude: 37.456, longitude: -122.15),
        dropoffLocation: .init(latitude: 37.042, longitude: -122.2),
        tripCost: 47.0,
        distanceToPassenger: 1000,
        travelTimeToPassenger: 24,
        state: .rejected
))
}

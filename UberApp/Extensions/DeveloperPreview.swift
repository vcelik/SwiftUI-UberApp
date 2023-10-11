//
//  DeveloperPreview.swift
//  UberApp
//
//  Created by Volkan Celik on 22/08/2023.
//

import SwiftUI
import Firebase

extension PreviewProvider{
    
    static var dev:DeveloperPreview{
        return DeveloperPreview.shared
    }
}

class DeveloperPreview{
    static let shared=DeveloperPreview()
    
    let mockTrip=Trip(
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
    )
    
    let mockUser=User(
        fullname: "Volkan Çelik",
        email: "celikvolkan85@gmail.com",
        uid: NSUUID().uuidString,
        coordinates: GeoPoint(latitude: 37.38, longitude: -122.05),
        accountType: .passenger,
        homeLocation: nil,
        workLocation: nil)
    
}

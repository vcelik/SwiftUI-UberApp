//
//  Trip.swift
//  UberApp
//
//  Created by Volkan Celik on 23/08/2023.
//

import FirebaseFirestoreSwift
import Firebase

enum TripState:Int,Codable{
    case requested
    case rejected
    case accepted
}

struct Trip:Identifiable,Codable{
    @DocumentID var tripId:String?
    let passengerUid:String
    let driverUid:String
    let passengerName:String
    let driverName:String
    let passengerLocation:GeoPoint
    let driverLocation:GeoPoint
    let pickupLocationName:String
    let dropoffLocationName:String
    let pickupLocationAddress:String
    let pickupLocatipn:GeoPoint
    let dropoffLocation:GeoPoint
    let tripCost:Double
    var distanceToPassenger:Double
    var travelTimeToPassenger:Int
    var state:TripState
    
    var id:String{
        return tripId ?? ""
    }
}

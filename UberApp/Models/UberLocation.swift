//
//  UberLocation.swift
//  UberApp
//
//  Created by Volkan Celik on 18/08/2023.
//

import CoreLocation

struct UberLocation:Identifiable{
    let id=NSUUID().uuidString
    let title:String
    let coordinate:CLLocationCoordinate2D
}

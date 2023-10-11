//
//  SavedLocation.swift
//  UberApp
//
//  Created by Volkan Celik on 22/08/2023.
//

import Firebase

struct SavedLocation:Codable{
    let title:String
    let address:String
    let coordinates:GeoPoint
}

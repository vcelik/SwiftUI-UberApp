//
//  User.swift
//  UberApp
//
//  Created by Volkan Celik on 21/08/2023.
//

import Foundation
import Firebase

enum AccountType:Int,Codable{
    case passenger
    case driver
}

struct User:Codable{
    let fullname:String
    let email:String
    let uid:String
    var coordinates:GeoPoint
    var accountType:AccountType
    var homeLocation:SavedLocation?
    var workLocation:SavedLocation?
}

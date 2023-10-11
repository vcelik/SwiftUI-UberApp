//
//  MapViewState.swift
//  UberApp
//
//  Created by Volkan Celik on 18/08/2023.
//

import Foundation

enum MapViewState{
    case noInput
    case searchingForLocation
    case locationSelected
    case polylineAdded
    case tripRequested
    case tripRejected
    case tripAccepted
}

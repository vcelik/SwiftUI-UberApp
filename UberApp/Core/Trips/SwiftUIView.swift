//
//  SwiftUIView.swift
//  UberApp
//
//  Created by Volkan Celik on 19/08/2023.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var selectedRideType:RideType = .uberX
    @EnvironmentObject var locationViewModel:LocationSearchViewModel
    var body: some View {
        Text("")

    }
}

#Preview {
    SwiftUIView()
}



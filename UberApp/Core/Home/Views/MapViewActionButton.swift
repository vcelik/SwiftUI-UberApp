//
//  MapViewActionButton.swift
//  UberApp
//
//  Created by Volkan Celik on 08/08/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    
    //@Binding var showLocationSearchView:Bool
    @Binding var mapState:MapViewState
    @Binding var showSideMenu:Bool
    @EnvironmentObject var viewModel:HomeViewModel
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity,alignment: .leading)

    }
    
    func actionForState(_ state:MapViewState){
        switch state{
        case .noInput:
            showSideMenu.toggle()
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected,.polylineAdded,.tripRejected,.tripAccepted,.tripRequested:
            mapState = .noInput
            viewModel.selectedUberLocation=nil
        }
    }
    
    func imageNameForState(_ state:MapViewState)->String{
        switch state{
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation,.locationSelected,.polylineAdded,.tripRejected,.tripAccepted,.tripRequested:
            return "arrow.left"
        default:
            return "Clear map view..."
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput),showSideMenu: .constant(false))
    }
}

//
//  HomewView.swift
//  UberApp
//
//  Created by Volkan Celik on 08/08/2023.
//

import SwiftUI

struct HomewView: View {
    
   // @State private var showLocationSearchView = false
    @State private var mapState=MapViewState.noInput
    @State private var showSideMenu=false
   // @EnvironmentObject var locationViewModel:LocationSearchViewModel
    @EnvironmentObject var authViewModel:AuthViewModel
    @EnvironmentObject var homeViewModel:HomeViewModel
    
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil{
                LoginView()
            }else if let user=authViewModel.currentUser{
                NavigationStack {
                    ZStack{
                        if showSideMenu{
                            SideMenu(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }
                    .onAppear{
                        showSideMenu=false
                    }
                }

            }

        }
    }
}

extension HomewView{
    var mapView: some View{
        ZStack(alignment:.bottom) {
            ZStack(alignment:.top) {
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation{
                    LocationSearchView()
                }else if mapState == .noInput{
                    LocationSearchActivationView()
                        .padding(.top,72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                            }
                        }
                }

                MapViewActionButton(mapState: $mapState,showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top,4)
            }
            
            if let user=authViewModel.currentUser{
                if user.accountType == .passenger{
                    if mapState == .locationSelected || mapState == .polylineAdded{
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }else if mapState == .tripRequested{
                        //show tri loading view
                        TripLoadingView()
                            .transition(.move(edge: .bottom))
                    }else if mapState == .tripAccepted{
                        //show trip accepted view
                        TripAcceptedView()
                            .transition(.move(edge: .bottom))
                    }else if mapState == .tripRejected{
                        //show rejection view
                    }
                }else{
                    if let trip=homeViewModel.trip{
                        AcceptTripView(trip: trip)
                            .transition(.move(edge: .bottom))
                    }
                }

            }
            

            

            
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            if let location=location{
                homeViewModel.userLocation=location
            }
    })
        .onReceive(homeViewModel.$selectedUberLocation, perform: { location in
            if location != nil{
                self.mapState = .locationSelected
            }
        })
        .onReceive(homeViewModel.$trip, perform: { trip in
            guard let trip=trip else {return}
            
            withAnimation(.spring()) {
                switch trip.state{
                case .requested:
                    self.mapState == .tripRequested
                case .rejected:
                    self.mapState == .tripRejected
                case .accepted:
                    self.mapState == .tripAccepted
                    
                }
            }

        })
        
        
    }
}

struct HomewView_Previews: PreviewProvider {
    static var previews: some View {
        HomewView()
            .environmentObject(AuthViewModel())
    }
}

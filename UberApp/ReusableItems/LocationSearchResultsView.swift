//
//  LocationSearchResultsView.swift
//  UberApp
//
//  Created by Volkan Celik on 21/08/2023.
//

import SwiftUI

struct LocationSearchResultsView: View {
    
    @StateObject var viewModel:HomeViewModel
    let config:LocationResultsViewConfig
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                ForEach(viewModel.results,id:\.self){result in
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring) {
                                viewModel.selectLocation(result, config: config)
                                //mapState = .locationSelected  we dont need to know anything about map state
                            }
                            
                            
                        }
                }
            }
        }
    }
}



//
//  SavedLocationSearchView.swift
//  UberApp
//
//  Created by Volkan Celik on 21/08/2023.
//

import SwiftUI

struct SavedLocationSearchView: View {
    
    @State private var text=""
    @StateObject var viewModel=HomeViewModel()
    let config:SavedLocationViewModel
    
    var body: some View {
        VStack{
            TextField("Search for a location...", text: $viewModel.queryFragment)
                .frame(height: 32)
                .padding(.leading)
                .background(Color(.systemGray5))
                .padding()
            Spacer()
            
            LocationSearchResultsView(viewModel: viewModel, config: .saveLocation(config))
        }
        .navigationTitle(config.subtitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SavedLocationSearchView(config: .home)
    }
}

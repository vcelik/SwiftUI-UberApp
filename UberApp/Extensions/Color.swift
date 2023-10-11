//
//  Color.swift
//  UberApp
//
//  Created by Volkan Celik on 19/08/2023.
//

import SwiftUI

extension Color{
   static let theme=ColorTheme()
}

struct ColorTheme{
    let backgroundColor=Color("BackgroundColor")
    let secondaryBackgroundColor=Color("SecondaryBackgroundColor")
    let primaryTextColor=Color("PrimaryTextColor")
}

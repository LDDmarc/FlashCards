//
//  ContentView.swift
//  FlashCards
//
//  Created by Дарья Леонова on 17.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            CardsStackView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

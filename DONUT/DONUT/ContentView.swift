//
//  ContentView.swift
//  DONUT
//
//  Created by Maxim Bazarov on 21.08.23.
//

import SwiftUI
import DonutShop

struct ContentView: View {
    var body: some View {
        NavigationStack {
            DonutGallery()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

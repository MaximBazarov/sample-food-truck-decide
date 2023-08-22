//
//  ApplicationEnvironment+Preview.swift
//  
//
//  Created by Anton Kolchunov on 21.08.23.
//

import Foundation
@testable import Decide

extension ApplicationEnvironment {
    static var preview: ApplicationEnvironment {
        bootstrap()
        return `default`
    }

    static func bootstrap(donuts: [Donut] = Donut.all) {
        `default`.setValue(donuts.map { $0.id }, \FoodTruckState.Index.$donut.wrappedValue)
        for donut in donuts {
            `default`.setValue(donut, \FoodTruckState.Data.$donut.wrappedValue, at: donut.id)
        }
        `default`.setValue(0, \FoodTruckState.$selectedDonut.wrappedValue)
    }
}

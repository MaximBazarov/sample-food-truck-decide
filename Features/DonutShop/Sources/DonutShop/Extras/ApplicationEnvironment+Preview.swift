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
        let allIds = Donut.all.map { $0.id }
        `default`.setValue(allIds, \NewFoodTruckState.Index.$donut.wrappedValue)
        for donut in Donut.all {
            `default`.setValue(donut, \NewFoodTruckState.Data.$donut.wrappedValue, at: donut.id)
        }

        `default`.setValue(1, \NewFoodTruckState.$selectedDonut.wrappedValue)
        return `default`
    }
}

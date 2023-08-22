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
        bootstrap(donuts.map { $0.id }, for: \FoodTruckState.Index.$donut)
        for donut in donuts {
            bootstrap(donut, for: \FoodTruckState.Data.$donut, at: donut.id)
        }
        bootstrap(0, for: \FoodTruckState.$selectedDonut)
    }

    // TODO: Move to Decide framework
    static func bootstrap<S: AtomicState, Value>(
        _ newValue: Value,
        for keyPath: KeyPath<S, Mutable<Value>>
    ) {
        `default`.setValue(
            newValue,
            keyPath.appending(path: \.wrappedValue)
        )
    }

    // TODO: Move to Decide framework
    static func bootstrap<I:Hashable, S: KeyedState<I>, Value>(
        _ newValue: Value,
        for keyPath: KeyPath<S, Mutable<Value>>,
        at identifier: I
    ) {
        `default`.setValue(
            newValue,
            keyPath.appending(path: \.wrappedValue),
            at: identifier)
    }
}

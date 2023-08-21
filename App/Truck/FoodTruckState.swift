//
//  FoodTruckState.swift
//  Food Truck
//
//  Created by Anton Kolchunov on 21.08.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Decide
import FoodTruckKit

final class FoodTruckState: AtomicState {
    @Mutable @Property public var selectedDonut: Donut.ID = -1

    final class Index: AtomicState {
        @Mutable @Property public var donut = [Donut.ID]()
    }

    final class Data: KeyedState<Donut.ID> {
        @Mutable @Property public var donut: Donut = Donut.newDonut
    }
}

extension Donut {
    static var newDonut = Donut(
        id: Donut.all.count,
        name: String(localized: "New Donut", comment: "New donut-placeholder name."),
        dough: .plain,
        glaze: .none,
        topping: .none
    )
}

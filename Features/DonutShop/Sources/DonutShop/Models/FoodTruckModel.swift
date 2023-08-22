/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The food truck model.
*/

import Decide

final class FoodTruckState: AtomicState {
    @Mutable @Property public var selectedDonut: Donut.ID = -1

    final class Index: AtomicState {
        @Mutable @Property public var donut = [Donut.ID]()
    }

    final class Data: KeyedState<Donut.ID> {
        @Mutable @Property public var donut: Donut = Donut.newDonut
    }
}


/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The food truck model.
*/

import Decide

final class DonutState: KeyedState<Int> {

    final class Index: AtomicState {
        @Mutable @Property public var all: [Donut.ID] = [0]
        @Mutable @Property public var editorDonut: Donut.ID = 0
    }
    
    @Mutable @Property public var name: String = String(localized: "New Donut", comment: "New donut-placeholder name.")
    @Mutable @Property public var dough: Donut.Dough = .plain
    @Mutable @Property public var glaze: Donut.Glaze? = .chocolate
    @Mutable @Property public var topping: Donut.Topping? = .blueberryLines
}

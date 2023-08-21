/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A donut view.
*/

import SwiftUI
import Decide

public let donutThumbnailSize: Double = 128

public struct DonutView: View {
    var id: Donut.ID
    var visibleLayers: DonutLayer = .all

    @ObserveKeyed(\DonutState.$name) var name
    @ObserveKeyed(\DonutState.$dough) var dough
    @ObserveKeyed(\DonutState.$glaze) var glaze
    @ObserveKeyed(\DonutState.$topping) var topping

    public init(id: Donut.ID, visibleLayers: DonutLayer = .all) {
        self.id = id
        self.visibleLayers = visibleLayers
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let useThumbnail = min(proxy.size.width, proxy.size.height) <= donutThumbnailSize

            ZStack {
                if visibleLayers.contains(.dough) {
                    dough[id].image(thumbnail: useThumbnail)
                        .resizable()
                        .interpolation(.medium)
                        .scaledToFit()
                        .id("DOUGH - \(id)")
                }

                if let glaze = glaze[id], visibleLayers.contains(.glaze) {
                    glaze.image(thumbnail: useThumbnail)
                        .resizable()
                        .interpolation(.medium)
                        .scaledToFit()
                        .id("GLAZE - \(id)")
                }

                if let topping = topping[id], visibleLayers.contains(.topping) {
                    topping.image(thumbnail: useThumbnail)
                        .resizable()
                        .interpolation(.medium)
                        .scaledToFit()
                        .id("TOPPING - \(id)")
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .compositingGroup()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

public struct DonutLayer: OptionSet {
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let dough = DonutLayer(rawValue: 1 << 1)
    public static let glaze = DonutLayer(rawValue: 1 << 2)
    public static let topping = DonutLayer(rawValue: 1 << 3)
    
    public static let all: DonutLayer = [dough, glaze, topping]
}

struct DonutCanvas_Previews: PreviewProvider {
    static var previews: some View {
        DonutView(id: 0)
    }
}

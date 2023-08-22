/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The grid view used in the DonutGallery.
*/

import Decide
import SwiftUI

struct DonutGalleryGrid: View {
    var donuts: [Donut.ID]
    var width: Double

    @ObserveKeyed(\FoodTruckState.Data.$donut) var donutsData

    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var useReducedThumbnailSize: Bool {
        if sizeClass == .compact {
            return true
        }
        
        if dynamicTypeSize >= .xxxLarge {
            return true
        }
        
        if width <= 390 {
            return true
        }
        
        return false
    }
    
    var cellSize: Double {
        useReducedThumbnailSize ? 100 : 150
    }
    
    var thumbnailSize: Double {
        return useReducedThumbnailSize ? 60 : 100
    }
    
    var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: cellSize), spacing: 20, alignment: .top)]
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(donuts, id: \.self) { donutId in
                NavigationLink(value: donutId) {
                    VStack {
                        DonutView(donut: donutsData[donutId])
                            .frame(width: thumbnailSize, height: thumbnailSize)

                        VStack {
                            let flavor = donutsData[donutId].flavors.mostPotentFlavor
                            Text(donutsData[donutId].name)
                            HStack(spacing: 4) {
                                flavor.image
                                Text(flavor.name)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
    }
}

struct DonutGalleryGrid_Previews: PreviewProvider {
    struct Preview: View {        
        var body: some View {
            NavigationStack {
                GeometryReader { geometryProxy in
                    ScrollView {
                        DonutGalleryGrid(
                            donuts: Donut.all.map { $0.id },
                            width: geometryProxy.size.width
                        )
                    }
                }
            }

        }
    }
    
    static var previews: some View {
        Preview()
            .appEnvironment(.preview)
    }
}

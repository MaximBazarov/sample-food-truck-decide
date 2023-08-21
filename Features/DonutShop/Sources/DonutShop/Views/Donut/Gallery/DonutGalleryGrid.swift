/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The grid view used in the DonutGallery.
*/

import SwiftUI
import Decide

struct DonutGalleryGrid: View {
    @Observe(\DonutState.Index.$all) var donuts

    @Observe(\DonutState.Index.$editorDonut) var selected

    @ObserveKeyed(\DonutState.$name) var name
    @ObserveKeyed(\DonutState.$dough) var dough
    @ObserveKeyed(\DonutState.$glaze) var glaze
    @ObserveKeyed(\DonutState.$topping) var topping

    var width: Double
    
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
            ForEach(donuts, id: \.self) { id in
                NavigationLink(value: id) {
                    VStack {
                        DonutView(id: id)
                            .frame(width: thumbnailSize, height: thumbnailSize)
                        Text(name[id])
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
//                        VStack {
////                            let flavor = donut.flavors.mostPotentFlavor
//                            Text(name[selected])
////                            HStack(spacing: 4) {
////                                flavor.image
////                                Text(flavor.name)
////                            }
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                        }
                            .multilineTextAlignment(.center)
                    }
                }


            }
            .buttonStyle(.plain)
        }
        .padding()
    }
}

struct DonutGalleryGrid_Previews: PreviewProvider {
    struct Preview: View {
        @State private var donuts = Donut.all
        
        var body: some View {
            GeometryReader { geometryProxy in
                ScrollView {
                    DonutGalleryGrid(width: geometryProxy.size.width)
                }
            }
        }
    }
    
    static var previews: some View {
        Preview()
    }
}

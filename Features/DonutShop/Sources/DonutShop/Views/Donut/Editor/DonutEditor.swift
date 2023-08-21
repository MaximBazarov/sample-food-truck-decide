/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donut editor view.
*/

import SwiftUI
import Decide

struct DonutEditor: View {
    @Observe(\DonutState.Index.$editorDonut) var selected

    @BindKeyed(\DonutState.$name) var name
    @ObserveKeyed(\DonutState.$dough) var dough
    @ObserveKeyed(\DonutState.$glaze) var glaze
    @ObserveKeyed(\DonutState.$topping) var topping

    
    var body: some View {
        ZStack {
            WidthThresholdReader { proxy in
                if proxy.isCompact {
                    Form {
                        donutViewer
                        editorContent
                    }
                } else {
                    HStack(spacing: 0) {
                        donutViewer
                        Divider().ignoresSafeArea()
                        Form {
                            editorContent
                        }
                        .formStyle(.grouped)
                        .frame(width: 350)
                    }
                }
            }
        }
        .toolbar {
            ToolbarTitleMenu {
                Button {

                } label: {
                    Label("My Action", systemImage: "star")
                }
            }
        }
        .navigationTitle(name[selected])
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
    
    var donutViewer: some View {
        DonutView(id: selected)
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .listRowInsets(.init())
            .padding(.horizontal, 40)
            .padding(.vertical)
            .background()
    }
    
    @ViewBuilder
    var editorContent: some View {
        Section("Donut") {
            TextField("Name", text: name[selected], prompt: Text("Donut Name"))
        }
        
//        Section("Flavor Profile") {
//            Grid {
//                let (topFlavor, topFlavorValue) = donut.flavors.mostPotent
//                ForEach(Flavor.allCases) { flavor in
//                    let isTopFlavor = topFlavor == flavor
//                    let flavorValue = max(donut.flavors[flavor], 0)
//                    GridRow {
//                        flavor.image
//                            .foregroundStyle(isTopFlavor ? .primary : .secondary)
//
//                        Text(flavor.name)
//                            .gridCellAnchor(.leading)
//                            .foregroundStyle(isTopFlavor ? .primary : .secondary)
//
//                        Gauge(value: Double(flavorValue), in: 0...Double(topFlavorValue)) {
//                            EmptyView()
//                        }
//                        .tint(isTopFlavor ? Color.accentColor : Color.secondary)
//                        .labelsHidden()
//
//                        Text(flavorValue.formatted())
//                            .gridCellAnchor(.trailing)
//                            .foregroundStyle(isTopFlavor ? .primary : .secondary)
//                    }
//                }
//            }
//        }
//
//        Section("Ingredients") {
//            Picker("Dough", selection: donut.dough) {
//                ForEach(Donut.Dough.all) { dough in
//                    Text(dough.name)
//                        .tag(dough)
//                }
//            }
//
//            Picker("Glaze", selection: donut.glaze) {
//                Section {
//                    Text("None")
//                        .tag(nil as Donut.Glaze?)
//                }
//                ForEach(Donut.Glaze.all) { glaze in
//                    Text(glaze.name)
//                        .tag(glaze as Donut.Glaze?)
//                }
//            }
//
//            Picker("Topping", selection: donut.topping) {
//                Section {
//                    Text("None")
//                        .tag(nil as Donut.Topping?)
//                }
//                Section {
//                    ForEach(Donut.Topping.other) { topping in
//                        Text(topping.name)
//                            .tag(topping as Donut.Topping?)
//                    }
//                }
//                Section {
//                    ForEach(Donut.Topping.lattices) { topping in
//                        Text(topping.name)
//                            .tag(topping as Donut.Topping?)
//                    }
//                }
//                Section {
//                    ForEach(Donut.Topping.lines) { topping in
//                        Text(topping.name)
//                            .tag(topping as Donut.Topping?)
//                    }
//                }
//                Section {
//                    ForEach(Donut.Topping.drizzles) { topping in
//                        Text(topping.name)
//                            .tag(topping as Donut.Topping?)
//                    }
//                }
//            }
//        }
    }
}

struct DonutEditor_Previews: PreviewProvider {
    struct Preview: View {
        var body: some View {
            DonutEditor()
        }
    }

    static var previews: some View {
        NavigationStack {
            Preview()
        }
    }
}

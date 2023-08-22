/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donut gallery view.
*/

import Decide
import SwiftUI

struct DonutGallery: View {
    @Bind(\FoodTruckState.$selectedDonut) var selectedDonut
    @Bind(\FoodTruckState.Index.$donut) var donutsIndex
    @ObserveKeyed(\FoodTruckState.Data.$donut) var donutsData

    @State private var layout = BrowserLayout.grid
    
    @State private var selection = Set<Donut.ID>()
    @State private var searchText = ""
    
    var filteredDonuts: [Donut.ID] {
        donutsIndex.filter { donutsData[$0].matches(searchText: searchText) }
    }
    
    var tableImageSize: Double {
        return 60
    }
    
    var body: some View {
        ZStack {
            if layout == .grid {
                grid
            } else {
                table
            }
        }
        .background()
        .toolbarRole(.browser)
        .toolbar {
            ToolbarItemGroup {
                toolbarItems
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Donuts")
        .navigationDestination(for: Donut.ID.self) { donut in
            DonutDetailsView()
                .onAppear {
                    selectedDonut = donut
                }
        }
        .navigationDestination(for: String.self) { donut in
            NewDonutEditor()
                .onAppear {
                   addNewDonut()
                }
        }
    }
    
    var grid: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                DonutGalleryGrid(
                    donuts: filteredDonuts,
                    width: geometryProxy.size.width
                )
            }
        }
    }

    var table: some View {
        Table(filteredDonuts, selection: $selection) {
            TableColumn("Name") { donutId in
                NavigationLink(value: donutId) {
                    HStack {
                        DonutView(donut: donutsData[donutId])
                            .frame(width: tableImageSize, height: tableImageSize)

                        Text(donutsData[donutId].name)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var toolbarItems: some View {
        NavigationLink(value: "New Donut") {
            Label("Create Donut", systemImage: "plus")
        }
        
        Menu {
            Picker("Layout", selection: $layout) {
                ForEach(BrowserLayout.allCases) { option in
                    Label(option.title, systemImage: option.imageName)
                        .tag(option)
                }
            }
            .pickerStyle(.inline)
        } label: {
            Label("Layout Options", systemImage: layout.imageName)
                .labelStyle(.iconOnly)
        }
    }

    func addNewDonut() {
        let newID = donutsIndex.count
        selectedDonut = newID
        donutsIndex.append(newID)
    }
}

enum BrowserLayout: String, Identifiable, CaseIterable {
    case grid
    case list

    var id: String {
        rawValue
    }

    var title: LocalizedStringKey {
        switch self {
        case .grid: return "Icons"
        case .list: return "List"
        }
    }

    var imageName: String {
        switch self {
        case .grid: return "square.grid.2x2"
        case .list: return "list.bullet"
        }
    }
}

struct DonutBakery_Previews: PreviewProvider {
    struct Preview: View {
        var body: some View {
            NavigationStack {
                DonutGallery()
            }
        }
    }

    static var previews: some View {
        Preview()
            .appEnvironment(.preview)
    }
}

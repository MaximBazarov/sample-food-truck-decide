/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donut gallery view.
*/

import SwiftUI
import Decide

public struct DonutGallery: View {
    @Bind(\DonutState.Index.$all) var donuts
    @Bind(\DonutState.Index.$editorDonut) var selectedDonut
    @ObserveKeyed(\DonutState.$name) var name
    
    @State private var layout = BrowserLayout.grid
    
    @State private var selection = Set<Donut.ID>()
    @State private var searchText = ""
    
    var filteredDonuts: [Donut.ID] {
        donuts
    }
    
    var tableImageSize: Double {
        return 60
    }

    public init() {}
    
    public var body: some View {
        let _ = Self._printChanges()
        return ZStack {
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
//        .searchable(text: $searchText)
        .navigationTitle("Donuts")
        .navigationDestination(for: Int.self) { id in
            DonutEditor()
                .onAppear {
                    selectedDonut = id
                }
        }
        .navigationDestination(for: String.self) { donut in
            DonutEditor()
                .onAppear {
                    let newID = donuts.count
                    selectedDonut = newID
                    donuts.append(newID)
                }
        }
    }
    
    var grid: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                DonutGalleryGrid(width: geometryProxy.size.width)
            }
        }
    }
    
    var table: some View {
        Table(filteredDonuts, selection: $selection) {
            TableColumn("Name") { id in
                NavigationLink(value: id) {
                    HStack {
                        DonutView(id: id)
                            .frame(width: tableImageSize, height: tableImageSize)

                        Text(name[id])
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
            DonutGallery()
        }
    }

    static var previews: some View {
        NavigationStack {
            Preview()
        }
    }
}


extension Int: Identifiable {
    public var id: Int {
        self
    }
}

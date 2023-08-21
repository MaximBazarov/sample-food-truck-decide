/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donut editor view.
*/

import SwiftUI
import Decide

struct DonutEditor: View {
    
    @Observe(\NewFoodTruckState.$selectedDonut) var id
    @BindKeyed(\NewFoodTruckState.Data.$donut) var donuts

    var body: some View {
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
    
    var donutViewer: some View {
        DonutView(donut: donuts[id])
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .listRowInsets(.init())
            .padding(.horizontal, 40)
            .padding(.vertical)
            .background()
    }
    
    @ViewBuilder
    var editorContent: some View {
        Section("Donut") {
            TextField("Name", text: donuts[id].name, prompt: Text("Donut Name"))
        }

        Section("Flavor profile") {
            DonatFlavorDetailsView(
                mostPotentFlavor: donuts[id].flavors.mostPotent,
                flavors: donuts[id].flavors
            )
        }
        
        Section("Ingredients") {
            DoughPicker(dough: donuts[id].dough)

            GlazePicker(glaze: donuts[id].glaze)

            ToppingPicker(topping: donuts[id].topping)
        }
    }
}

struct DonutEditor_Previews: PreviewProvider {
    struct Preview: View {
        var body: some View {
            NavigationView {
                DonutEditor()
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}

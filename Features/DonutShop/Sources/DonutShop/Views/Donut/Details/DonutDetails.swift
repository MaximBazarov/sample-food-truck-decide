//
//  DonutDetails.swift
//
//
//  Created by Anton Kolchunov on 11.08.23.
//

import SwiftUI
import Decide

struct DonutDetailsView: View {
    @State private var isPresentingEditor = false
    @Observe(\NewFoodTruckState.$selectedDonut) var detailsDonut
    @ObserveKeyed(\NewFoodTruckState.Data.$donut) var donuts

    var body: some View {
        DonutDetails()
            .edgesIgnoringSafeArea(.all)
            .navigationTitle(donuts[detailsDonut].name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        isPresentingEditor = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingEditor) {
                NavigationView {
                    DetailsDonutEditor()
                }
            }
    }
}

struct DonutDetails: UIViewControllerRepresentable {
    typealias UIViewControllerType = DonutDetailsTableViewController

    func makeUIViewController(context: Context) -> DonutDetailsTableViewController {
        DonutDetailsTableViewController()
    }

    func updateUIViewController(_ uiViewController: DonutDetailsTableViewController, context: Context) {
        // Don't need to do anything here
    }
}

struct DonutDetailsPreview: PreviewProvider {
    struct Preview: View {
        var body: some View {
            NavigationView {
                DonutDetailsView()
            }
        }
    }

    static var previews: some View {
        Preview()
            .appEnvironment(.preview)
    }
}

class DonutDetailsTableViewController: UITableViewController, EnvironmentObservingObject {

    @DefaultEnvironment var environment
    @DefaultObserve(\NewFoodTruckState.$selectedDonut) var selectedDonut
    @DefaultObserveKeyed(\NewFoodTruckState.Data.$donut) var donuts

    var donut: Donut {
        donuts[selectedDonut]
    }

    func environmentDidUpdate() {
        tableView.reloadData()
    }

    let sections = ["", "Flavor profile", "Ingredients"]
    let ingredientsTitles = ["Dough", "Glaze", "Topping"]

    init() {
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        environmentDidUpdate()

        tableView.register(DonutDetailsCell.self, forCellReuseIdentifier: DonutDetailsCell.identifier)
        tableView.register(DonutIngredientCell.self, forCellReuseIdentifier: DonutIngredientCell.identifier)
        tableView.contentInsetAdjustmentBehavior = .always

        self.tableView.isScrollEnabled =  false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 3
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DonutDetailsCell.identifier,
                for: indexPath
            ) as! DonutDetailsCell
            let view = indexPath.section == 0 ? buildDonutView() : buildFlavorDetailsView()
            cell.configure(view)
            return cell
        }

        let cell = buildIngredientsCell(for: indexPath)
        return cell
    }

    private func buildDonutView() -> any View {
        return DonutView(donut: donut)
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .listRowInsets(.init())
            .padding(.horizontal, 20)
            .padding(.vertical)
            .background()
    }

    private func buildFlavorDetailsView() -> any View {
        return DonatFlavorDetailsView(
            mostPotentFlavor: donut.flavors.mostPotent,
            flavors: donut.flavors
        ).padding(20)
    }

    private func buildIngredientsCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DonutIngredientCell.identifier,
            for: indexPath
        ) as! DonutIngredientCell
        let ingredient = getIngredient(for: indexPath)
        cell.nameLabel.text = ingredientsTitles[indexPath.row]
        cell.valueLabel.text = ingredient?.name ?? "None"
        cell.selectionStyle = .none
        return cell
    }

    private func getIngredient(for indexPath: IndexPath) -> (any Ingredient)? {
        switch indexPath.row {
        case 0:
            return donut.dough
        case 1:
            return donut.glaze
        case 2:
            return donut.topping
        default:
            fatalError()
        }
    }
}

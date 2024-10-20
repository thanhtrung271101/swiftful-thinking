//
//  CoreDataBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 20/10/24.
//

import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - manages the data for a view

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching... \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}

struct CoreDataBootcamp: View {
    @StateObject var viewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Add fruit here ...", text: $textFieldText)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray4))
                    )
                    .padding(.horizontal)
                
                Button("Add") {
                    guard !textFieldText.isEmpty else { return }
                    viewModel.addFruit(text: textFieldText)
                    textFieldText = ""
                }
                .font(.headline)
                .foregroundStyle(Color(.white))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.pink)
                )
                .padding(.horizontal)
                List {
                    ForEach(viewModel.savedEntities) { entity in
                        Text(entity.name ?? "NO NAME")
                            .onTapGesture {
                                viewModel.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataBootcamp()
}

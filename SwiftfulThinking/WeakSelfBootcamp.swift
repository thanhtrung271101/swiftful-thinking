//
//  WeakSelfBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 20/10/24.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    @AppStorage("count") var count: Int?
    init() {
        count = 0
    }
    var body: some View {
        
        NavigationStack {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.green))
                )
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    @StateObject var viewModel = WeakSelfSecondScreenViewModel()
    var body: some View {
        VStack {
            Text("SECOND SCREEN")
                .font(.largeTitle)
                .foregroundStyle(Color(.red))
            if let data = viewModel.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        newData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func newData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!"
        }
    }
}

#Preview {
    WeakSelfBootcamp()
}

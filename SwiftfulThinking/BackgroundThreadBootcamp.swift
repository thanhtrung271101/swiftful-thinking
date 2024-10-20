//
//  BackgroundThreadBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 20/10/24.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    @StateObject var viewModel = BackgroundThreadViewModel()
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        viewModel.fetchData()
                    }
                ForEach(viewModel.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}

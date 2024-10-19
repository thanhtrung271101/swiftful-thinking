//
//  ArraysBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 19/10/24.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Trung", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 10, isVerified: false)
        let user3 = UserModel(name: "Tom", points: 15, isVerified: true)
        let user4 = UserModel(name: nil, points: 2, isVerified: false)
        let user5 = UserModel(name: "Jax", points: 4, isVerified: false)
        let user6 = UserModel(name: "Makai", points: 12, isVerified: true)
        let user7 = UserModel(name: "Sun", points: 53, isVerified: true)
        let user8 = UserModel(name: nil, points: 23, isVerified: true)
        let user9 = UserModel(name: "Moon", points: 55, isVerified: false)
        let user10 = UserModel(name: "Eric", points: 22, isVerified: true)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
    func updateFilteredArray() {
        // sort
        /*
         filteredArray = dataArray.sorted(by: { (user1, user2) -> Bool in
                    return user1.points > user2.points
                })
                filteredArray = dataArray.sorted(by: { $0.points > $1.points})
         */
        
        // filter
        /*
         filteredArray = dataArray.filter({ $0.isVerified })
         */
        
        // map
        /*
//        mappedArray = dataArray.map({ user in
//            return user.name ?? "nil"
//        })
//        mappedArray = dataArray.map({ $0.name })
        
//        mappedArray = dataArray.compactMap({ user in
//            return user.name
//        })
        mappedArray = dataArray.compactMap({ $0.name })
*/
        
        mappedArray = dataArray
                        .sorted(by: { $0.points < $1.points })
                        .filter({ $0.isVerified })
                        .compactMap({ $0.name })
    }
}

struct ArraysBootcamp: View {
    @StateObject var viewModel = ArrayModificationViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(viewModel.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("\(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(Color.white)
//                    .padding()
//                    .background(Color.blue)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}

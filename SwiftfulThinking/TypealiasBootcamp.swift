//
//  TypealiasBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 20/10/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
//    @State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    @State var item: TVModel = TVModel(title: "News", director: "Emily", count: 10)
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}

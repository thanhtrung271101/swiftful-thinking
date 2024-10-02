//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 3/10/24.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    var body: some View {
        VStack {
            TextField("Enter a # here ...", text: $textFieldText)
                .frame(height: 56)
                .border(Color(.gray))
                .padding(.horizontal)
                .keyboardType(.numberPad)
            Button("SCROLL NOW") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0 ..< 50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color(.white))
                            )
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}

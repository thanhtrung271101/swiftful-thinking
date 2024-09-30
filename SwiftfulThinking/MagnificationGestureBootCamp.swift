//
//  MagnificationGesture.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 29/9/24.
//

import SwiftUI

struct MagnificationGestureBootCamp: View {
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 32, height: 32)
                Text("Thanh Trung")
                    .font(.subheadline)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            Text("This is a caption of this image!")
        }
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.title)
//            .padding(40)
//            .background(Color(.red))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded { value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    }
//                    
//            )
    }
}

#Preview {
    MagnificationGestureBootCamp()
}

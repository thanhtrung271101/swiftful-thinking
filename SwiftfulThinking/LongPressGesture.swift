//
//  LongPressGesture.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 27/9/24.
//

import SwiftUI

struct LongPressGesture: View {
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color(.green) : Color(.blue))
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 56)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.gray))
            HStack {
                Text("CLICK HERE")
                    .foregroundStyle(Color(.white))
                    .padding()
                    .background(Color(.black))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                Text("RESET")
                    .foregroundStyle(Color(.white))
                    .padding()
                    .background(Color(.black))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }


            }
        }
//        Text(isComplete ? "Completed" : "Not completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color(.green) : Color(.gray))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 5.0) {
//                isComplete.toggle()
//            }
        
    }
}

#Preview {
    LongPressGesture()
}

//
//  RotationGestureBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 1/10/24.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    @State var angle: Angle = Angle(degrees: 0)
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(Color(.white))
            .padding(40)
            .background(Color(.blue))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .rotationEffect(angle)
            .gesture (
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        angle = Angle(degrees: 0)
                    }
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}

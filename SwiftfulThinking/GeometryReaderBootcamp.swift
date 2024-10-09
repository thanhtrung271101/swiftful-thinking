//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 9/10/24.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    func getPercentage(geo: GeometryProxy) -> Double {
        var maxDistance: CGFloat {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return 0
            }
            return windowScene.screen.bounds.width / 2
        }
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 20) { index in
                    GeometryReader { geometry in
                        Rectangle()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
//        GeometryReader { geometry in
//            HStack {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle()
//                    .fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
}

#Preview {
    GeometryReaderBootcamp()
}

//
//  DragGestureBootcamp2.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 2/10/24.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    @State private var startingOffsetY: CGFloat = 0.0
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpView(chevronTapAction: {
                withAnimation(.spring()) {
                    endingOffsetY = endingOffsetY == 0 ? -startingOffsetY : 0
                }
            }, isExpanded: endingOffsetY != 0)
            .offset(y: startingOffsetY)
            .offset(y: currentDragOffsetY)
            .offset(y: endingOffsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            currentDragOffsetY = value.translation.height
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if currentDragOffsetY < -150 {
                                endingOffsetY = -startingOffsetY
                            } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                endingOffsetY = 0
                            }
                            currentDragOffsetY = 0
                        }
                    }
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                startingOffsetY = window.bounds.height * 0.85
            }
        }
    }
}

struct MySignUpView: View {
    var chevronTapAction: () -> Void
    var isExpanded: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                .padding(.top)
                .onTapGesture {
                    chevronTapAction()
                }
            
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .padding(.horizontal)
                .background(Color(.black))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    DragGestureBootcamp2()
}

//
//  ContentView.swift
//  Shared
//
//  Created by Seogun Kim on 2022/03/03.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTY
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    //MARK: - FUNCTION
    
    //MARK: - CONTENT
    
    
    var body: some View {
        NavigationView {
            ZStack {
             //MARK: - PAGE IMAGE
             Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                             imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    })
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
        }
        .navigationViewStyle(.stack) // 아이패드에서 사이드바를 제공하지 않음
    }
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
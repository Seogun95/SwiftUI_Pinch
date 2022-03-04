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
    @State private var imageOffset: CGSize = .zero
    //MARK: - FUNCTION
    func resetImageState() {
        withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    //MARK: - CONTENT
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //Color.clear를 사용해 INFO FANEL이 ZStack 영역의 TOP부분으로 나오게 함
                Color.clear
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                //MARK: - 1. onTapGesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                           /* withAnimation(.spring()) {
                                imageScale = 1
                            }  */
                            resetImageState()
                        }
                    })
                //MARK: - 2. DrageGesture
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = gesture.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        
                    )
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            //MARK: - INFO PANEL
            .overlay(
             InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
             , alignment: .top
            )
            //MARK: - CONTROLS
            .overlay(
                Group {
                    HStack{
                        // SCALE DOWN
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        // RESET
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // SCALE UP
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }//: CONTROLS
                    .padding(EdgeInsets(top: 12, leading:20, bottom: 12, trailing: 20))
                    .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 10))
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30), alignment: .bottom
            )
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

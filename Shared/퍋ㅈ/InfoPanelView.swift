//
//  InfoPanelView.swift
//  SwiftUI_Pinch (iOS)
//
//  Created by Seogun Kim on 2022/03/03.
//

import SwiftUI

struct InfoPanelView: View {
    //MARK: - PROPERTY
    
    //아이콘을 길게 누르기전 INFO 패널을 숨김(LongPressGesture)
    @State private var isInfoPanelVisible: Bool = false
    var scale: CGFloat
    var offset: CGSize
    
    var body: some View {
        HStack {
            //MARK: - HOTSPOT : SwiftUI 버튼을 사용하지 않고 버튼 효과
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                //minimumDuration은 얼마의 시간동안 누를지를 정해줌
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            
            //MARK: - INFO PANEL
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale, specifier: "%.2f")")
                    .frame(width: 50, alignment: .leading)
                    .padding(.leading, 10)
                Spacer()
                    
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width, specifier: "%.2f")")
                    .frame(width: 50, alignment: .leading)
                    .padding(.leading, 10)
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height, specifier: "%.2f")")
                    .frame(width: 50, alignment: .leading)
                    .padding(.leading, 10)
                Spacer()
            }
            .font(.footnote)
            .padding(10)
            //iOS 15 에 추가된 background blur 효과 Material
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: 400)
//            isInfoPanelVisible이 False이면 숨겨짐
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

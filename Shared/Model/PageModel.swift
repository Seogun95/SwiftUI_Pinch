//
//  PageModel.swift
//  SwiftUI_Pinch (iOS)
//
//  Created by Seogun Kim on 2022/03/05.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}

//
//  SwiftUIView.swift
//  ScreenShieldDemo
//
//  Created by 熊进辉 on 2025/7/12
//  Copyright © 2025/7/12 datacloak. All rights reserved.
//
    

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ScreenShieldSwiftUIView(antiScreenshot: true) {
            VStack {
                Text("Hello, World!")
                Text("Hello, Swift!")
                Text("Hello, SwiftUI!")
            }
        }
    }
}

#Preview {
    SwiftUIView()
}

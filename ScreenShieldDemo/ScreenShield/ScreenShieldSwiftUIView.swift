//
//  ScreenShieldSwiftUIView.swift
//  ScreenShieldDemo
//
//  Created by 熊进辉 on 2025/7/12
//  Copyright © 2025/7/12 datacloak. All rights reserved.
//
    

import SwiftUI

struct ScreenShieldSwiftUIView<Content: View>: UIViewRepresentable{
    let content: Content
    let antiScreenshot:Bool

    init(antiScreenshot:Bool, @ViewBuilder content: () -> Content ) {
        self.antiScreenshot = antiScreenshot
        self.content = content()
    }

    // MARK: - Coordinator 用于缓存 HostingController
    class Coordinator {
        var hostingController: UIHostingController<Content>?

        init(_ hostingController: UIHostingController<Content>?) {
            self.hostingController = hostingController
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(nil)
    }

    func makeUIView(context: Context) -> UIView {
        var shieldView:UIView
        if self.antiScreenshot == true{
            let protectedView = UIView();
            protectedView.backgroundColor = .purple;
            shieldView = ScreenShieldView.create(frame: .zero,protectedView: protectedView)
        }else{
            shieldView = UIView()
        }

        let hostingController = UIHostingController(rootView: content)
        context.coordinator.hostingController = hostingController

        let hostedView = hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = false //是 Auto Layout 中的一个属性，用于控制视图的自动布局行为。当你手动使用 Auto Layout（比如添加约束）时，这个属性的设置至关重要。

        shieldView.addSubview(hostedView)

        NSLayoutConstraint.activate([
            hostedView.topAnchor.constraint(equalTo: shieldView.topAnchor),
            hostedView.bottomAnchor.constraint(equalTo: shieldView.bottomAnchor),
            hostedView.leadingAnchor.constraint(equalTo: shieldView.leadingAnchor),
            hostedView.trailingAnchor.constraint(equalTo: shieldView.trailingAnchor)
        ])

        return shieldView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // 关键：在状态变化时更新 rootView 内容
        context.coordinator.hostingController?.rootView = content
    }
}

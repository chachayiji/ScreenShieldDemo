//
//  ScreenShieldView.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

@available(iOS 13.0, *)
public class ScreenShieldView: UIView {
    private var protectedView: UIView? = nil //自定义截屏视图
    private var portiereView: UIView? = nil
    
    @objc public static func create(frame: CGRect = .zero) -> ScreenShieldView {
        return ScreenShieldView(frame: frame,protectedView: nil)
    }
    
    @objc public static func create(frame: CGRect = .zero, protectedView: UIView?) -> ScreenShieldView {
        return ScreenShieldView(frame: frame,protectedView: protectedView)
    }
    
    public override var backgroundColor: UIColor? {
        get {
            super.backgroundColor
        }
        set {
            super.backgroundColor = newValue
            self.portiereView?.backgroundColor = newValue
        }
    }
    
    private init(frame: CGRect, protectedView: UIView?) {
        super.init(frame: frame)
        safeZone = makeSecureView() ?? UIView()
        self.protectedView = protectedView
        
        if let sf = safeZone {
            if self.protectedView != nil {
                self.protectedView?.removeFromSuperview()
                super.addSubview(self.protectedView!)
                self.protectedView!.snp.makeConstraints { make in
                    make.top.equalTo(0)
                    make.bottom.equalTo(0)
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                }
            }
            
            addSubview(sf)
            
            let layoutDefaultLowPriority = UILayoutPriority(rawValue: UILayoutPriority.defaultLow.rawValue-1)
            let layoutDefaultHighPriority = UILayoutPriority(rawValue: UILayoutPriority.defaultHigh.rawValue-1)
            
            sf.translatesAutoresizingMaskIntoConstraints = false
            sf.setContentHuggingPriority(layoutDefaultLowPriority, for: .vertical)
            sf.setContentHuggingPriority(layoutDefaultLowPriority, for: .horizontal)
            sf.setContentCompressionResistancePriority(layoutDefaultHighPriority, for: .vertical)
            sf.setContentCompressionResistancePriority(layoutDefaultHighPriority, for: .horizontal)
            
            let top = NSLayoutConstraint.init(item: sf, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint.init(item: sf, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint.init(item: sf, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint.init(item: sf, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            
            self.addConstraints([top, bottom, leading, trailing])
            
            if self.protectedView != nil {
                let portiereView = UIView()
                portiereView.backgroundColor = .white
                self.addSubview(portiereView)
                portiereView.snp.makeConstraints { make in
                    make.top.equalTo(0)
                    make.bottom.equalTo(0)
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                }
                self.portiereView = portiereView
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(appWillLeave(_:)), name: UIApplication.willResignActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(appDidBack(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
            
        }
    }
    
    @objc private func appWillLeave(_ notify:Notification){
          self.protectedView?.isHidden = true
     }
    @objc private func appDidBack(_ notify:Notification){
            self.protectedView?.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func addSubview(_ view: UIView) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.addSubview(view)
            return
        }
        safe.addSubview(view)
    }
    
    public override func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.insertSubview(view, belowSubview: siblingSubview)
            return
        }
        safe.insertSubview(view, belowSubview: siblingSubview)
    }
    
    public override func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.insertSubview(view, aboveSubview: siblingSubview)
            return
        }
        safe.insertSubview(view, aboveSubview: siblingSubview)
    }
    
    public override func insertSubview(_ view: UIView, at index: Int) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.insertSubview(view, at: index)
            return
        }
        if self.protectedView != nil ,index == 0 {
            safe.insertSubview(view, at: 1)
        }else{
            safe.insertSubview(view, at: index)
        }
    }

    public override func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        guard
            let safe = safeZone
        else {
            super.exchangeSubview(at: index1, withSubviewAt: index2)
            return
        }
        safe.exchangeSubview(at: index1, withSubviewAt: index2)
    }
    
    public override func bringSubviewToFront(_ view: UIView) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.bringSubviewToFront(view)
            return
        }
        safe.bringSubviewToFront(view)
    }
    
    public override func sendSubviewToBack(_ view: UIView) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.sendSubviewToBack(view)
            return
        }
        safe.sendSubviewToBack(view)
    }
    
    public var safeSubviews: [UIView] {
        guard let safe = safeZone else {
            return super.subviews
        }
        return safe.subviews
    }
    
    private func makeSecureView() -> UIView? {
        guard isOSVersionSafe else {
            return nil
        }
        
        let field = UITextField()
        field.isSecureTextEntry = true
        let fv = field.subviews.first
        fv?.subviews.forEach { $0.removeFromSuperview() }
        fv?.isUserInteractionEnabled = true
        
        let errorMsg = "[ScreenShieldView log] Create safeZone failed!"
#if DEBUG
        precondition(fv != nil, errorMsg)
#else
        print(errorMsg)
#endif
        
        return fv
    }
    
    
    private var safeZone: UIView?
    
    // Some OS version may crash, ignore them before there is a better way.
    private var unsafeOSVersion: [String] {
        ["15.1"]
    }
    
    private var osVersion: String {
        UIDevice.current.systemVersion
    }
    
    private var isOSVersionSafe: Bool {
        for version in unsafeOSVersion {
            if osVersion.contains(version) {
                return false
            }
        }
        return true
    }
    
}

#endif

//
//  BaseScreenShieldView.swift
//  ScreenShieldDemo
//
//  Created by 熊进辉 on 2025/7/12
//  Copyright © 2025/7/12 datacloak. All rights reserved.
//
    

import UIKit
import SnapKit

class BaseScreenShieldView: UIView {
    private var contentView:ScreenShieldView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupContent(){
        self.contentView = ScreenShieldView.create(frame: CGRectZero)
        self.addSubview(self.contentView!)
        self.contentView?.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.bottom.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
   
    override func addSubview(_ view: UIView) {
        if (contentView != nil) {
            contentView!.addSubview(view)
        } else {
            super.addSubview(view)
        }
    }

    override func insertSubview(_ view: UIView, at index: Int) {
        if (contentView != nil) {
            contentView!.insertSubview(view, at: index)
        } else {
            super.insertSubview(view, at: index)
        }
    }

    override func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView) {
        if (contentView != nil) {
            contentView!.insertSubview(view, aboveSubview: siblingSubview)
        } else {
            super.insertSubview(view, aboveSubview: siblingSubview)
        }
    }

    override func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        if (contentView != nil) {
            contentView!.insertSubview(view, belowSubview: siblingSubview)
        } else {
            super.insertSubview(view, belowSubview: siblingSubview)
        }
    }

    override func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        if (contentView != nil) {
            contentView!.exchangeSubview(at: index1, withSubviewAt: index2)
        } else {
            super.exchangeSubview(at: index1, withSubviewAt: index2)
        }
    }

    override func bringSubviewToFront(_ view: UIView) {
        if (contentView != nil) {
            contentView!.bringSubviewToFront(view)
        } else {
            super.bringSubviewToFront(view)
        }
    }

    override func sendSubviewToBack(_ view: UIView) {
        if (contentView != nil) {
            contentView!.sendSubviewToBack(view)
        } else {
            super.sendSubviewToBack(view)
        }
    }
}

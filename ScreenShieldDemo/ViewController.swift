//
//  ViewController.swift
//  ScreenShieldDemo
//
//  Created by 熊进辉 on 2025/7/4
//  Copyright © 2025/7/4 datacloak. All rights reserved.
//
    

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
   
    override func loadView() {
        super.loadView()
        
        let protectedView = UIView()
        protectedView.backgroundColor = .red
        self.view = ScreenShieldView.create(frame: UIScreen.main.bounds ,protectedView: protectedView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.setupUI()
    }

    func setupUI(){
        let title = UILabel()
        title.text = "ScreenShield"
        title.textColor = .white
        title.textAlignment = .center
        title.backgroundColor = .blue
        self.view .addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        
        let button = UIButton(type: .custom)
        button.setTitle("SwiftUI", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(swiftUIAction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(50)
        }
        
        let button1 = UIButton(type: .custom)
        button1.frame = CGRectMake(20, 220, self.view.frame.size.width - 40, 50)
        button1.setTitle("To Setting", for: .normal)
        button1.titleLabel?.textColor = .white
        button1.backgroundColor = .purple
        button1.addTarget(self, action: #selector(swiftUIAction(_:)), for: .touchUpInside)
        self.view.addSubview(button1)
    }
    
    @objc func swiftUIAction(_ sender: UIButton) {
    
        if let url = URL(string: UIApplication.openSettingsURLString){
            UIApplication.shared.open(url)
        }
    }

}


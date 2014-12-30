//
//  ViewController.swift
//  UnyAlert
//
//  Created by Yuki Nagai on 12/30/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

import UIKit
import UnyAlert

class ViewController: UIViewController {

    let successButton = UIButton()
    let errorButton = UIButton()
    let warningButton = UIButton()
    let infoButton = UIButton()
    let loadingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.prepare(button: self.successButton, title: "success")
        self.prepare(button: self.errorButton, title: "error")
        self.prepare(button: self.warningButton, title: "warning")
        self.prepare(button: self.infoButton, title: "info")
        self.prepare(button: self.loadingButton, title: "loading")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = CGRectGetWidth(self.view.frame)
        let height = CGRectGetHeight(self.view.frame)
        self.successButton.center = CGPoint(x: floor(width / 4), y: floor(height / 4))
        self.errorButton.center = CGPoint(x: floor(width * 3 / 4), y: floor(height / 4))
        self.warningButton.center = CGPoint(x: floor(width / 2), y: floor(height / 2))
        self.infoButton.center = CGPoint(x: floor(width / 4), y: floor(height * 3 / 4))
        self.loadingButton.center = CGPoint(x: floor(width * 3 / 4), y: floor(height * 3 / 4))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepare(#button: UIButton, title: String) {
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor(red: 0.0, green: 122.0/255, blue: 1.0, alpha: 1.0), forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
        button.addTarget(self, action: NSSelectorFromString(title), forControlEvents: .TouchUpInside)
        button.sizeToFit()
        self.view.addSubview(button)
    }
    
    // MARK - Events
    func success() {
        let alertView = UnyAlert.AlertView()
        alertView.showSuccess(title: "成功したよ！", message: "成功やったね成功やったね成功やったね成功やったね", duration: 3.0)
    }
    func error() {
        
    }
    func warning() {
        
    }
    func info() {
        
    }
    func loading() {
        
    }
}

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
        var textFields = [UITextField]()
        let firstField = UITextField()
        firstField.placeholder = "First"
        textFields.append(firstField)
        let secondField = UITextField()
        secondField.placeholder = "Second"
        textFields.append(secondField)
        alertView.textFields = textFields
        var buttons = [UIButton]()
        let firstButton = UIButton()
        firstButton.setTitle("First", forState: .Normal)
        firstButton.addTarget(self, action: "didTap:", forControlEvents: .TouchUpInside)
        buttons.append(firstButton)
        let secondButton = UIButton()
        secondButton.setTitle("Second", forState: .Normal)
        buttons.append(secondButton)
        let thirdButton = UIButton()
        thirdButton.setTitle("Third", forState: .Normal)
        buttons.append(thirdButton)
        alertView.buttons = buttons
        alertView.showSuccess(title: "成功したよ！", message: "成功やったね成功やったね成功やったね成功やったね")
    }
    func error() {
        let alertView = UnyAlert.AlertView()
        let button = UIButton()
        button.setTitle("OK", forState: .Normal)
        alertView.buttons = [button]
        alertView.showError(title: "エラー", message: "どうにかして直してください")
    }
    func warning() {
        let alertView = UnyAlert.AlertView()
        alertView.showWarning(title: "警告", duration: 1.0)
    }
    func info() {
        let alertView = UnyAlert.AlertView()
        let textField = UITextField()
        textField.placeholder = "First"
        alertView.textFields = [textField]
        let button = UIButton()
        button.setTitle("登録？", forState: .Normal)
        alertView.buttons = [button]
        alertView.showWarning(title: "ちょっとちょっと", message: "何かを入力してください")
    }
    func loading() {
        let alertView = UnyAlert.AlertView()
        alertView.showLoading(title: "通信中？", message: "いえええええい")
        NSTimer.scheduledTimerWithTimeInterval(3.0,
            target: self, selector: "timeup:", userInfo: ["alertView": alertView], repeats: false)
    }
    
    // MARK - Button events
    func didTap(sender: UIButton) {
        println("Tapped by \(sender)")
    }
    // MARK - Timer events
    func timeup(timer: NSTimer) {
        let alertView = timer.userInfo!["alertView"] as UnyAlert.AlertView
        alertView.close()
    }
}

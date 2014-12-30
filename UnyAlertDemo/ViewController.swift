//
//  ViewController.swift
//  UnyAlertDemo
//
//  Created by Yuki Nagai on 12/29/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

import UIKit
import UnyAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let view = UnyAlert.AlertView()
        view.showSuccess(title: "Success", message: "あああああああああああああああああああああああああああああああああああああああ")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


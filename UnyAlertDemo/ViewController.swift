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
        
        self.view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        
        let view = UnyAlert.showSuccess()
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


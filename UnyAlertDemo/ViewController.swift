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
        
        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 90.0))
        button.titleLabel?.text = "TAP ME!"
        button.addTarget(self, action: "didTap", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func didTap() {
        let vc = UnyAlert.showSuccess()
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  UnyAlert.swift
//  UnyAlert
//
//  Created by Yuki Nagai on 12/29/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

// TODO: 必要なかったら消す
import UIKit

/// 1つのビューを使い回し
let alertView = AlertView()

public func showSuccess() -> UIView {
    return IconView(type: .Checkmark)
}

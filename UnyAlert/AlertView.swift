//
//  AlertView.swift
//  UnyAlert
//
//  Created by Yuki Nagai on 12/30/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

import UIKit

/**
アラートビュー
*/
class AlertView: UIView {
    /// Subviewたちはタグから引く
    enum ViewTag: Int {
        case Content = 1
        case Circle
        case Icon
    }
    
    /// 背景透明度
    var opacity: CGFloat = 0.7
    /// 角丸
    var corderRadius: CGFloat = 5.0
    /// アイコン丸半径
    var circleRadius: CGFloat = 3.0
    
    override init() {
        super.init(frame: CGRectZero)
        // Content view
        let contentView = UIView()
        self.addSubview(contentView)
        contentView.tag = ViewTag.Content.rawValue
        contentView.backgroundColor = UIColor.whiteColor()
        // Circle
        let circleView = UIView()
        contentView.addSubview(circleView)
        circleView.tag = ViewTag.Circle.rawValue
        circleView.layer.masksToBounds = true
        // Icon
        
        // -> Circle for icon
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

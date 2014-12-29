//
//  IconView.swift
//  UnyAlert
//
//  Created by Yuki Nagai on 12/30/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

import UIKit

/**
ベジエでアイコン作成
*/
class IconView: UIView {
    let iconType: IconType
    
    enum IconType {
        case Checkmark
    }
    
    init(type: IconType) {
        self.iconType = type
        /// Viewサイズはアイコンタイプによって調整
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0))
        
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        switch self.iconType {
        case .Checkmark:
            drawCheckmark()
        }
    }
    
    // MARK - Drawing
    /*
    SCLAlertView.swift by Viktor Radchenko
    */
    /**
    チェックマーク描画
    */
    func drawCheckmark() {
        let bezierPath = UIBezierPath()
        // 右上から
        bezierPath.moveToPoint(CGPoint(x: 73.25, y: 14.05))
        bezierPath.addCurveToPoint(CGPoint(x: 64.51, y: 13.86), controlPoint1: CGPoint(x: 70.98, y: 11.44), controlPoint2: CGPoint(x: 66.78, y: 11.26))
        // 折れ目
        bezierPath.addLineToPoint(CGPoint(x: 27.46, y: 52.0))
        // 左上
        bezierPath.addLineToPoint(CGPoint(x: 15.75, y: 39.54))
        bezierPath.addCurveToPoint(CGPoint(x: 6.84, y: 39.54), controlPoint1: CGPoint(x: 13.48, y: 36.93), controlPoint2: CGPoint(x: 9.28, y: 36.93))
        bezierPath.addCurveToPoint(CGPoint(x: 6.84, y: 49.02), controlPoint1: CGPoint(x: 4.39, y: 42.14), controlPoint2: CGPoint(x: 4.39, y: 46.42))
        bezierPath.addLineToPoint(CGPoint(x: 22.91, y: 66.14))
        bezierPath.addCurveToPoint(CGPoint(x: 27.28, y: 68.0), controlPoint1: CGPoint(x: 24.14, y: 67.44), controlPoint2: CGPoint(x: 25.71, y: 68.0))
        bezierPath.addCurveToPoint(CGPoint(x: 31.65, y: 66.14), controlPoint1: CGPoint(x: 28.86, y: 68.0), controlPoint2: CGPoint(x: 30.43, y: 67.26))
        bezierPath.addLineToPoint(CGPoint(x: 73.08, y: 23.35))
        bezierPath.addCurveToPoint(CGPoint(x: 73.25, y: 14.05), controlPoint1: CGPoint(x: 75.52, y: 20.75), controlPoint2: CGPoint(x: 75.7, y: 16.65))
        bezierPath.closePath()
        bezierPath.miterLimit = 4
        
        UIColor.whiteColor().setFill()
        bezierPath.fill()
    }
    
    /**
    
    */
}

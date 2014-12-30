//
//  IconFactory.swift
//  UnyAlert
//
//  Created by Yuki Nagai on 12/30/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

import UIKit

/**
UIView - drawRectだと描画処理分コスト高そうなので素直にUIImageで生成
*/
class IconFactory {
    /// アイコン種類
    enum IconType: Int {
        case Check = 0
        case Cross
        case Exclamation
        case Info
    }
    /// 各アイコン一度生成したらここから引く
    struct Cache {
        static var images = [Int: UIImage]()
    }
    
    /**
    アイコン生成
    
    :param: type アイコンの種類
    */
    class func icon(type: IconType) -> UIImage {
        if let cached = Cache.images[type.rawValue] {
            // キャッシュがあれば返す
            return cached
        }
        // Viktorが80 x 80で書いてくれている
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), false, 0)
        switch type {
        case .Check:
            drawCheck()
        case .Cross:
            drawCross()
        case .Exclamation:
            drawExclamation()
        case .Info:
            drawInfo()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        Cache.images[type.rawValue] = image
        return image
    }
    
    // MARK - Drawing, referencing from SCLAlertView.swift by Viktor Radchenko
    /**
    チェックマーク描画
    */
    class func drawCheck() {
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
        bezierPath.miterLimit = 4.0
        
        UIColor.whiteColor().setFill()
        bezierPath.fill()
    }
    
    /**
    バツマーク描画
    */
    class func drawCross() {
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 10.0, y: 70.0))
        bezierPath.addLineToPoint(CGPoint(x: 70.0, y: 10.0))
        bezierPath.moveToPoint(CGPoint(x: 10.0, y: 10.0))
        bezierPath.addLineToPoint(CGPoint(x: 70.0, y: 70.0))
        // 端点スタイル
        bezierPath.lineCapStyle = kCGLineCapRound
        bezierPath.lineJoinStyle = kCGLineJoinRound
        UIColor.whiteColor().setStroke()
        bezierPath.lineWidth = 14.0
        bezierPath.stroke()
    }
    
    /**
    ビックリマーク描画
    */
    class func drawExclamation() {
        UIColor.whiteColor().setFill()
        
        let circlePath = UIBezierPath()
        circlePath.moveToPoint(CGPoint(x: 40.94, y: 63.39))
        circlePath.addCurveToPoint(CGPoint(x: 36.03, y: 65.55), controlPoint1: CGPoint(x: 39.06, y: 63.39), controlPoint2: CGPoint(x: 37.36, y: 64.18))
        circlePath.addCurveToPoint(CGPoint(x: 34.14, y: 70.45), controlPoint1: CGPoint(x: 34.9, y: 66.92), controlPoint2: CGPoint(x: 34.14, y: 68.49))
        circlePath.addCurveToPoint(CGPoint(x: 36.22, y: 75.54), controlPoint1: CGPoint(x: 34.14, y: 72.41), controlPoint2: CGPoint(x: 34.9, y: 74.17))
        circlePath.addCurveToPoint(CGPoint(x: 40.94, y: 77.5), controlPoint1: CGPoint(x: 37.54, y: 76.91), controlPoint2: CGPoint(x: 39.06, y: 77.5))
        circlePath.addCurveToPoint(CGPoint(x: 45.86, y: 75.35), controlPoint1: CGPoint(x: 42.83, y: 77.5), controlPoint2: CGPoint(x: 44.53, y: 76.72))
        circlePath.addCurveToPoint(CGPoint(x: 47.93, y: 70.45), controlPoint1: CGPoint(x: 47.18, y: 74.17), controlPoint2: CGPoint(x: 47.93, y: 72.41))
        circlePath.addCurveToPoint(CGPoint(x: 45.86, y: 65.35), controlPoint1: CGPoint(x: 47.93, y: 68.49), controlPoint2: CGPoint(x: 47.18, y: 66.72))
        circlePath.addCurveToPoint(CGPoint(x: 40.94, y: 63.39), controlPoint1: CGPoint(x: 44.53, y: 64.18), controlPoint2: CGPoint(x: 42.83, y: 63.39))
        circlePath.closePath()
        circlePath.miterLimit = 4.0
        circlePath.fill()
        
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPoint(x: 46.23, y: 4.26))
        shapePath.addCurveToPoint(CGPoint(x: 40.94, y: 2.5), controlPoint1: CGPoint(x: 44.91, y: 3.09), controlPoint2: CGPoint(x: 43.02, y: 3.09))
        shapePath.addCurveToPoint(CGPoint(x: 34.71, y: 4.26), controlPoint1: CGPoint(x: 38.68, y: 2.5), controlPoint2: CGPoint(x: 36.03, y: 3.09))
        shapePath.addCurveToPoint(CGPoint(x: 31.5, y: 8.77), controlPoint1: CGPoint(x: 33.01, y: 5.44), controlPoint2: CGPoint(x: 31.5, y: 7.01))
        shapePath.addLineToPoint(CGPoint(x: 31.5, y: 19.36))
        shapePath.addLineToPoint(CGPoint(x: 34.71, y: 54.44))
        shapePath.addCurveToPoint(CGPoint(x: 40.38, y: 58.16), controlPoint1: CGPoint(x: 34.9, y: 56.2), controlPoint2: CGPoint(x: 36.41, y: 58.16))
        shapePath.addCurveToPoint(CGPoint(x: 45.76, y: 54.44), controlPoint1: CGPoint(x: 44.34, y: 58.16), controlPoint2: CGPoint(x: 45.67, y: 56.01))
        shapePath.addLineToPoint(CGPoint(x: 48.5, y: 19.36))
        shapePath.addLineToPoint(CGPoint(x: 48.5, y: 8.77))
        shapePath.addCurveToPoint(CGPoint(x: 46.23, y: 4.26), controlPoint1: CGPoint(x: 48.5, y: 7.01), controlPoint2: CGPoint(x: 47.74, y: 5.44))
        shapePath.closePath()
        shapePath.miterLimit = 4.0
        shapePath.fill()
    }
    
    /**
    インフォメーションマーク描画
    */
    class func drawInfo() {
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 45.66, y: 15.96))
        bezierPath.addCurveToPoint(CGPoint(x: 45.66, y: 5.22), controlPoint1: CGPoint(x: 48.78, y: 12.99), controlPoint2: CGPoint(x: 48.78, y: 8.19))
        bezierPath.addCurveToPoint(CGPoint(x: 34.34, y: 5.22), controlPoint1: CGPoint(x: 42.53, y: 2.26), controlPoint2: CGPoint(x: 37.47, y: 2.26))
        bezierPath.addCurveToPoint(CGPoint(x: 34.34, y: 15.96), controlPoint1: CGPoint(x: 31.22, y: 8.19), controlPoint2: CGPoint(x: 31.22, y: 12.99))
        bezierPath.addCurveToPoint(CGPoint(x: 45.66, y: 15.96), controlPoint1: CGPoint(x: 37.47, y: 18.92), controlPoint2: CGPoint(x: 42.53, y: 18.92))
        bezierPath.closePath()
        
        bezierPath.moveToPoint(CGPoint(x: 48.0, y: 69.41))
        bezierPath.addCurveToPoint(CGPoint(x: 40.0, y: 77.0), controlPoint1: CGPoint(x: 48.0, y: 73.58), controlPoint2: CGPoint(x: 44.4, y: 77.0))
        bezierPath.addLineToPoint(CGPoint(x: 40.0, y: 77.0))
        bezierPath.addCurveToPoint(CGPoint(x: 32.0, y: 69.41), controlPoint1: CGPoint(x: 35.6, y: 77.0), controlPoint2: CGPoint(x: 32.0, y: 73.58))
        bezierPath.addLineToPoint(CGPoint(x: 32.0, y: 35.26))
        bezierPath.addCurveToPoint(CGPoint(x: 40.0, y: 27.67), controlPoint1: CGPoint(x: 32.0, y: 31.08), controlPoint2: CGPoint(x: 35.6, y: 27.67))
        bezierPath.addLineToPoint(CGPoint(x: 40.0, y: 27.67))
        bezierPath.addCurveToPoint(CGPoint(x: 48.0, y: 35.26), controlPoint1: CGPoint(x: 44.4, y: 27.67), controlPoint2: CGPoint(x: 48.0, y: 31.08))
        bezierPath.addLineToPoint(CGPoint(x: 48.0, y: 69.41))
        bezierPath.closePath()
        
        UIColor.whiteColor().setFill()
        bezierPath.fill()
    }
}

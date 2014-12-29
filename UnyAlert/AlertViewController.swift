//
//  AlertViewController.swift
//  UnyAlert
//
//  Created by Yuki Nagai on 12/29/14.
//  Copyright (c) 2014 Yuki Nagai. All rights reserved.
//

import UIKit

// TODO: UIViewにする
class AlertViewController: UIViewController {
    /// View tags
    enum ViewTag: Int {
        case Content = 1
        case CircleBack
        case Circle
        case Icon
        case Title
        case Message
    }
    
    /// 背景透明度
    let defaultOpacity: CGFloat = 0.7
    /// 角丸
    let defaultRadius: CGFloat = 5.0
    /// アイコン丸枠幅
    let defaultCircleBorderWidth: CGFloat = 3.0
    /// アイコン丸半径
    let defaultCircleRadius: CGFloat = 28.0
    /// アイコン画像幅
    let defaultIconWidth: CGFloat = 20.0
    /// フォント太字
    let defaultBoldFontName = "HiraKakuProN-W6"
    /// フォントノーマル
    let defaultFontName = "HiraKakuProN-W3"
    /// タイトルフォントサイズ
    let defaultTitleSize: CGFloat = 20.0
    /// メッセージフォントサイズ
    let defaultMessageSize: CGFloat = 14.0
    /// アラート幅：は固定
    let defaultMargin: CGFloat = 20.0
    
    /*
    TODO: それぞれdefaultに対応して変数を用意して、didSetで関連画面の更新を行う
    */
    
    override init() {
        super.init()
        // Main view
        self.view.backgroundColor = UIColor(white: 0.0, alpha: self.defaultOpacity)
        // Content view
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.tag = ViewTag.Content.rawValue
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.cornerRadius = self.defaultRadius
        contentView.layer.masksToBounds = true
        // <- Circle view
        // Back
        let circleBackView = UIView()
        contentView.addSubview(circleBackView)
        circleBackView.tag = ViewTag.CircleBack.rawValue
        circleBackView.backgroundColor = UIColor.whiteColor()
        let circleBackViewRadius = self.defaultCircleRadius + self.defaultCircleBorderWidth
        let circleBackViewDiameter = circleBackViewRadius * 2.0
        circleBackView.frame.size = CGSize(width: circleBackViewDiameter, height: circleBackViewDiameter)
        circleBackView.layer.cornerRadius = circleBackViewRadius
        // Circle
        // CircleとアイコンはCircleBackViewのサイズが固定で中心配置すれば良いのでこれらだけここで位置指定
        let circleView = UIView()
        circleBackView.addSubview(circleView)
        circleView.tag = ViewTag.Circle.rawValue
        circleView.center = CGPoint(x: circleBackViewRadius, y: circleBackViewRadius)
        let circleDiameter = self.defaultCircleRadius * 2.0
        circleView.frame.size = CGSize(width: circleDiameter, height: circleDiameter)
        circleView.layer.cornerRadius = self.defaultCircleRadius
        // Icon
        let iconView = UIImageView()
        circleView.addSubview(iconView)
        iconView.tag = ViewTag.Icon.rawValue
        iconView.center = CGPoint(x: self.defaultCircleRadius, y: self.defaultCircleRadius)
        iconView.frame.size = CGSize(width: self.defaultIconWidth, height: self.defaultIconWidth)
        // -> Circle view
        // Title
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.tag = ViewTag.Title.rawValue
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont(name: self.defaultBoldFontName, size: self.defaultTitleSize)!
        // Message
        let messageLabel = UILabel()
        contentView.addSubview(messageLabel)
        messageLabel.tag = ViewTag.Message.rawValue
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: self.defaultFontName, size: self.defaultMessageSize)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Update frame
        /// スクリーンサイズ
        var screenSize = UIScreen.mainScreen().bounds.size
        /// システムバージョン
        let systemVersion = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        if systemVersion < 8.0 {
            // 8.0以前はローテーションで幅と高さを変えてくれないらしい
            if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
                screenSize = CGSize(width: screenSize.height, height: screenSize.width)
            }
        }
        // Main
        self.view.frame.size = screenSize
        // その他はタイトルなどが設定された時に
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

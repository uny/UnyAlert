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
public class AlertView: UIView {
    /// アラートの種類
    enum AlertType {
        case Success
        case Error
        case Warning
        case Info
        case Loading
    }
    
    // Viewたち
    /// 載せるView
    var contentView: UIView!
    /*
    タイトル、メッセージ更新時はもう一度showメソッド群を呼ぶ
    */
    /// タイトル
    var titleLabel: UILabel!
    /// 詳細メッセージ
    var messageLabel: UILabel!

    /*
    変数たち
    共通で変更したい場合はUIAppearance経由で
    Swiftではdynamicを付ければAppearanceからaccessibleになる
    */
    /// 背景透明度
    public dynamic var backgroundOpacity: CGFloat = 0.6
    /// Content view 横マージン、縦は内容に合わせて
    public dynamic var alertMargin: CGFloat = 20.0
    /// 各部品ごとマージン
    public dynamic var contentMargin: CGFloat = 10.0
    /// 角丸
    public dynamic var cornerRadius: CGFloat = 5.0
    /// アイコン丸半径
    public dynamic var circleRadius: CGFloat = 28.0
    /// アイコン倍率（0.0 - 1.0）
    public dynamic var iconScale: CGFloat = 0.2
    /// 標準フォント
    public dynamic var fontName = "HiraKakuProN-W3"
    /// 太字フォント
    public dynamic var boldFontName = "HiraKakuProN-W6"
    /// タイトルフォントサイズ
    public dynamic var titleFontSize: CGFloat = 20.0
    /// メッセージフォントサイズ
    public dynamic var messageFontSize: CGFloat = 14.0
    /// テキストフィールドフォントサイズ
    public dynamic var textFieldFontSize: CGFloat = 14.0
    /// ボタンフォントサイズ
    public dynamic var buttonFontSize: CGFloat = 14.0
    /// テキストフィールドたち：直接足してね
    public var textFields = [UITextField]()
    /// ボタンたち：targetなしならclose
    public var buttons = [UIButton]()
    /// アイコン丸の下端：
    var circleMaxY: CGFloat = 0.0
    
    // MARK - Showing
    /**
    成功通知
    */
    public func showSuccess(#title: String, message: String = "", duration: NSTimeInterval? = nil) {
        self.show(title: title, message: message, duration: duration, type: .Success)
    }
    
    /**
    通知共通処理
    */
    func show(#title: String, message: String, duration: NSTimeInterval?, type: AlertType) {
        // 変数を反映しながら
        if self.superview == nil {
            // まず載せる
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.backgroundColor = UIColor(white: 0.0, alpha: self.backgroundOpacity)
            window.addSubview(self)
            window.makeKeyAndVisible()
        }
        // 透明からアニメーション
        self.alpha = 0.0
        // Main view
        let keyWindow = UIApplication.sharedApplication().keyWindow!
        keyWindow.addSubview(self)
        self.frame = keyWindow.bounds
        self.backgroundColor = UIColor(white: 0.0, alpha: self.backgroundOpacity)
        // Content view 高さはあとから
        let contentView = UIView()
        self.addSubview(contentView)
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.frame.size.width = CGRectGetWidth(self.frame) - (self.alertMargin * 2.0)
        contentView.center.x = self.center.x
        let cornerRadius = self.cornerRadius
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        self.contentView = contentView
        // 内容配置
        let alertWidth = CGRectGetWidth(contentView.frame)
        let centerX = floor(alertWidth / 2.0)
        let contentMargin = self.contentMargin
        let alertColor = self.color(type)
        // アイコン丸
        if let iconImage = iconImage(type) {
            // アイコンがあるなら丸View作って配置
            let circleView = UIView()
            contentView.addSubview(circleView)
            let circleRadius = self.circleRadius
            let circleDiameter = circleRadius * 2.0
            circleView.frame.size = CGSize(width: circleDiameter, height: circleDiameter)
            circleView.center.x = centerX
            circleView.frame.origin.y = contentMargin
            self.circleMaxY = CGRectGetMaxY(circleView.frame)
            circleView.layer.cornerRadius = circleRadius
            circleView.backgroundColor = alertColor
            // アイコン画像セット
            let iconView = UIImageView(image: iconImage)
            circleView.addSubview(iconView)
            iconView.contentMode = .ScaleAspectFit
            let iconSize = iconImage.size
            let iconScale = self.iconScale
            iconView.frame.size = CGSize(
                width: iconSize.width * iconScale,
                height: iconSize.height * iconScale)
            iconView.center = CGPoint(x: circleRadius, y: circleRadius)
        } else {
            // アイコン画像がないときはローディング
            let indicatorView = UIActivityIndicatorView()
            contentView.addSubview(indicatorView)
            indicatorView.center.x = centerX
            indicatorView.frame.origin.y = contentMargin
            self.circleMaxY = CGRectGetMaxY(indicatorView.frame)
            indicatorView.startAnimating()
        }
        // 以降の位置調整は変更がありうるのでupdateFramesで
        let fontName = self.fontName
        let boldFontName = self.boldFontName
        let titleFontSize = self.titleFontSize
        let messageFontSize = self.messageFontSize
        // Title
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: boldFontName, size: titleFontSize)!
        titleLabel.numberOfLines = 1
        titleLabel.text = title
        self.titleLabel = titleLabel
        // Message
        let messageLabel = UILabel()
        contentView.addSubview(messageLabel)
        messageLabel.font = UIFont(name: fontName, size: messageFontSize)!
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        self.messageLabel = messageLabel
        // TextFields
        for textField in self.textFields {
            contentView.addSubview(textField)
        }
        // Buttons
        for button in self.buttons {
            button.backgroundColor = alertColor
            contentView.addSubview(button)
        }
        updateFrames()
        UIView.animateWithDuration(0.3, animations: { () in
            self.alpha = 1.0
        }) { (finished) in
        }
    }
    
    /**
    UILabelの内容変更やUITextField/UIButton追加に伴うフレーム更新処理
    */
    func updateFrames() {
        let contentView = self.contentView
        let alertWidth = CGRectGetWidth(contentView.frame)
        let circleMaxY = self.circleMaxY
        let centerX = floor(alertWidth / 2.0)
        let contentMargin = self.contentMargin
        /// マージン考慮したUITextField/UIbutton幅
        let contentWidth = alertWidth - (contentMargin * 2.0)
        // Title
        let titleLabel = self.titleLabel
        titleLabel.frame = CGRectZero
        titleLabel.sizeToFit()
        titleLabel.center.x = centerX
        titleLabel.frame.origin.y = circleMaxY + contentMargin
        // Message
        let messageLabel = self.messageLabel
        messageLabel.frame = CGRect(x: 0.0, y: 0.0, width: contentWidth, height: CGFloat.max)
        messageLabel.sizeToFit()
        messageLabel.center.x = centerX
        messageLabel.frame.origin.y = CGRectGetMaxY(titleLabel.frame) + contentMargin
        /// 下端
        var y = CGRectGetMaxY(messageLabel.frame) + contentMargin
        // TextFields
        for textField in self.textFields {
            textField.center.x = centerX
            textField.frame.origin.y = y
            y = CGRectGetMaxY(textField.frame) + contentMargin
        }
        // Buttons
        for button in self.buttons {
            button.center.x = centerX
            button.frame.origin.y = y
            y = CGRectGetMaxY(button.frame) + contentMargin
        }
        // Content view height
        contentView.frame.size.height = y
        contentView.center.y = self.center.y
    }
    
    /**
    アラートカラー
    */
    func color(type: AlertType) -> UIColor {
        // Bootstrap color
        switch type {
        case .Success:
            // #5cb85c
            return UIColor(red: 92.0/255, green: 184.0/255, blue: 92.0/255, alpha: 1.0)
        case .Error:
            // #d9534f
            return UIColor(red: 217.0/255, green: 83.0/255, blue: 79.0/255, alpha: 1.0)
        case .Warning:
            // #f0ad4e
            return UIColor(red: 240.0/255, green: 173.0/255, blue: 78.0/255, alpha: 1.0)
        case .Info:
            // #5bc0de
            return UIColor(red: 91.0/255, green: 192.0/255, blue: 222.0/255, alpha: 1.0)
        case .Loading:
            // #337ab7
            return UIColor(red: 51.0/255, green: 122.0/255, blue: 183.0/255, alpha: 1.0)
        }
    }
    
    /**
    アイコン
    */
    func iconImage(type: AlertType) -> UIImage? {
        var iconType: IconFactory.IconType?
        switch type {
        case .Success:
            iconType = .Check
        case .Error:
            iconType = .Cross
        case .Warning:
            iconType = .Exclamation
        case .Info:
            iconType = .Info
        default:
            iconType = nil
        }
        if let iconType = iconType {
            // アイコン画像返す
            return IconFactory.icon(iconType)
        } else {
            // 何も返さない
            return nil
        }
    }
}

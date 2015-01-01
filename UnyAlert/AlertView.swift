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
    
    /// 複数呼び出したとき用のキュー
    struct Queue {
        static var alerts = [AlertView]()
    }
    
    // Viewたち
    /// 載せるView
    let contentView = UIView()
    /// アイコン丸
    let circleView = UIView()
    /// アイコンImageView
    let iconView = UIImageView()
    /// ぐるぐる：背景白固定なのでスタイル他に選択肢ないので今の所固定
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    /*
    タイトル、メッセージ更新するにはもう一度showメソッド群を呼ぶ
    */
    /// タイトル
    let titleLabel = UILabel()
    /// 詳細メッセージ
    let messageLabel = UILabel()
    /// プログレスバー
    let progressView = UIProgressView()
    
    // 定数たち
    /// コンテンツ載せるビュー背景色
    let contentViewColor = UIColor.whiteColor()
    
    /*
    変数たち
    共通で変更したい場合はUIAppearance経由で
    Swiftではdynamicを付ければAppearanceからaccessibleになる
    */
    /// 表示非表示アニメーション時間
    public dynamic var duration = 0.3
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
    /// テキストフィールド高さ
    public dynamic var textFieldHeight: CGFloat = 30.0
    /// テキストフィールドフォントサイズ
    public dynamic var textFieldFontSize: CGFloat = 14.0
    /// ボタン高さ
    public dynamic var buttonHeight: CGFloat = 35.0
    /// ボタンフォントサイズ
    public dynamic var buttonFontSize: CGFloat = 14.0
    /// テキストフィールドたち：直接足してね
    public var textFields = [UITextField]()
    /// ボタンたち：押されたらclose
    public var buttons = [UIButton]()
    /// プログレス（0.0 - 1.0 or nil）
    public var progress: Float? = nil {
        didSet {
            // プログレス更新
            let progressView = self.progressView
            if let progress = self.progress {
                if progressView.superview != nil {
                    // 更新
                    progressView.setProgress(progress, animated: true)
                }
            }
            // それ以外は画面全更新するはず：画面新規作成・プログレス不要時
        }
    }
    /// 非表示タイマー
    var timer: NSTimer?
    
    // MARK - Showing
    /**
    成功通知
    */
    public func showSuccess(#title: String, message: String = "", duration: NSTimeInterval? = nil) {
        self.show(title: title, message: message, duration: duration, type: .Success)
    }
    /**
    エラー通知
    */
    public func showError(#title: String, message: String = "", duration: NSTimeInterval? = nil) {
        self.show(title: title, message: message, duration: duration, type: .Error)
    }
    /**
    警告通知
    */
    public func showWarning(#title: String, message: String = "", duration: NSTimeInterval? = nil) {
        self.show(title: title, message: message, duration: duration, type: .Warning)
    }
    /**
    情報通知
    */
    public func showInfo(#title: String, message: String = "", duration: NSTimeInterval? = nil) {
        self.show(title: title, message: message, duration: duration, type: .Info)
    }
    /**
    ぐるぐる
    */
    public func showLoading(#title: String, message: String = "", duration: NSTimeInterval? = nil) {
        self.show(title: title, message: message, duration: duration, type: .Loading)
    }
    
    /**
    通知共通処理
    */
    func show(#title: String, message: String, duration: NSTimeInterval?, type: AlertType) {
        // 前のアラートたちはとりあえず非表示
        for alert in Queue.alerts {
            alert.hidden = true
        }
        // 変数を反映しながら
        if self.superview == nil {
            // 新規キュー
            Queue.alerts.append(self)
            /*
            まず載せる：載せ方が結構面倒
            windowのfirst subviewに載せると良い感じにrotationしてくれるらしい
            ただしモーダルと一緒に使ったりすると問題が発生する？
            http://stackoverflow.com/questions/2508630/orientation-in-a-uiview-added-to-a-uiwindow
            まぁSCLAlertViewもこのやり方だし...
            */
            let firstView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView
            firstView.addSubview(self)
            self.frame = firstView.bounds
            self.backgroundColor = UIColor(white: 0.0, alpha: self.backgroundOpacity)
        }
        // とりあえず隠しておく（openで表示処理）
        self.hidden = true
        // Content view
        let contentView = self.contentView
        let contentViewColor = self.contentViewColor
        if contentView.superview == nil {
            self.addSubview(contentView)
            contentView.backgroundColor = contentViewColor
            // 高さは全部載せ終わってから
            let width = CGRectGetWidth(self.frame)
            contentView.frame.size.width = width - (self.alertMargin * 2.0)
            contentView.center.x = floor(width / 2.0)
            contentView.layer.cornerRadius = self.cornerRadius
            contentView.layer.masksToBounds = true
        }
        // 内容配置
        let alertWidth = CGRectGetWidth(contentView.frame)
        let centerX = floor(alertWidth / 2.0)
        let contentMargin = self.contentMargin
        let alertColor = self.alertColor(type)
        var circleMaxY: CGFloat = 0.0
        // アイコン丸
        let circleView = self.circleView
        let indicatorView = self.indicatorView
        // とりあえず丸たち隠す：載せたら載せっぱで隠しとけば良いや
        circleView.hidden = true
        indicatorView.stopAnimating()
        indicatorView.hidden = true
        if let iconImage = iconImage(type) {
            // アイコンがあるなら丸Viewにアイコンセット
            circleView.hidden = false
            if circleView.superview == nil {
                contentView.addSubview(circleView)
                let circleRadius = self.circleRadius
                let circleDiameter = circleRadius * 2.0
                circleView.frame.size = CGSize(width: circleDiameter, height: circleDiameter)
                circleView.center.x = centerX
                circleView.frame.origin.y = contentMargin
                circleView.layer.cornerRadius = circleRadius
            }
            circleView.backgroundColor = alertColor
            circleMaxY = CGRectGetMaxY(circleView.frame)
            // アイコン画像をセット
            let iconView = self.iconView
            if iconView.superview == nil {
                circleView.addSubview(iconView)
                iconView.contentMode = .ScaleAspectFit
            }
            iconView.image = iconImage
            let iconSize = iconImage.size
            let iconScale = self.iconScale
            iconView.frame.size = CGSize(
                width: iconSize.width * iconScale,
                height: iconSize.height * iconScale)
            iconView.center = CGPoint(x: circleRadius, y: circleRadius)
        } else {
            // アイコン画像がないときはローディング
            indicatorView.hidden = false
            if indicatorView.superview == nil {
                contentView.addSubview(indicatorView)
                indicatorView.center.x = centerX
                indicatorView.frame.origin.y = contentMargin
            }
            indicatorView.startAnimating()
            circleMaxY = CGRectGetMaxY(indicatorView.frame)
        }
        // ここから大事な内容が始まります
        /// マージン考慮したUITextField/UIbutton幅
        let contentWidth = alertWidth - (contentMargin * 2.0)
        let fontName = self.fontName
        let boldFontName = self.boldFontName
        // Title
        let titleLabel = self.titleLabel
        let titleFontSize = self.titleFontSize
        if titleLabel.superview == nil {
            contentView.addSubview(titleLabel)
            titleLabel.numberOfLines = 1
            titleLabel.font = UIFont(name: boldFontName, size: titleFontSize)!
        }
        titleLabel.text = title
        titleLabel.frame = CGRectZero
        titleLabel.sizeToFit()
        titleLabel.center.x = centerX
        titleLabel.frame.origin.y = circleMaxY + contentMargin
        // Message
        let messageLabel = self.messageLabel
        let messageFontSize = self.messageFontSize
        if messageLabel.superview == nil {
            contentView.addSubview(messageLabel)
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont(name: fontName, size: messageFontSize)!
        }
        messageLabel.text = message
        messageLabel.frame = CGRect(x: 0.0, y: 0.0, width: contentWidth, height: CGFloat.max)
        messageLabel.sizeToFit()
        messageLabel.center.x = centerX
        messageLabel.frame.origin.y = CGRectGetMaxY(titleLabel.frame) + contentMargin
        /// 下端
        var y = CGRectGetMaxY(messageLabel.frame) + contentMargin
        // TextFields
        let textFieldHeight = self.textFieldHeight
        let textFieldFontSize = self.textFieldFontSize
        for textField in self.textFields {
            if textField.superview == nil {
                contentView.addSubview(textField)
                textField.borderStyle = .RoundedRect
                textField.layer.borderColor = alertColor.CGColor
                textField.font = UIFont(name: fontName, size: textFieldFontSize)!
                textField.frame = CGRectZero
                textField.frame.size = CGSize(width: contentWidth, height: textFieldHeight)
                textField.center.x = centerX
            }
            textField.frame.origin.y = y
            y = CGRectGetMaxY(textField.frame) + contentMargin
        }
        // Buttons
        let buttonHeight = self.buttonHeight
        let buttonFontSize = self.buttonFontSize
        for button in self.buttons {
            if button.superview == nil {
                contentView.addSubview(button)
                button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                button.titleLabel?.font = UIFont(name: boldFontName, size: buttonFontSize)!
                button.frame = CGRectZero
                button.frame.size = CGSize(width: contentWidth, height: buttonHeight)
                button.center.x = centerX
            }
            button.backgroundColor = alertColor
            button.frame.origin.y = y
            y = CGRectGetMaxY(button.frame) + contentMargin
            // ボタンを押したけれどアラート閉じないなんてことはないはず
            button.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
        }
        // Progress bar領域確保：進捗管理はdidSet
        let progressView = self.progressView
        if let progress = self.progress {
            // プログレス必要
            if progressView.superview == nil {
                contentView.addSubview(progressView)
                progressView.trackTintColor = contentViewColor
                progressView.setProgress(progress, animated: false)
                progressView.frame.size.width = alertWidth
                progressView.center.x = floor(alertWidth / 2)
                progressView.frame.origin.y = y
                y = CGRectGetMaxY(progressView.frame)
            }
        } else {
            // プログレス不要論
            if progressView.superview != nil {
                progressView.removeFromSuperview()
            }
        }
        // Content view height
        contentView.frame.size.height = y
        contentView.center.y = self.center.y
        
        if let duration = duration {
            // Durationで閉じる：多重アラートで途中で非表示になっても時間は止めない
            self.timer = NSTimer.scheduledTimerWithTimeInterval(duration,
                target: self, selector: "close", userInfo: nil, repeats: false)
        }
        
        self.open()
    }
    
    /**
    開く：表示処理 with animation
    showメソッド群によってコンテンツは既に生成されている前提
    */
    func open() {
        self.hidden = false
        self.alpha = 0.0
        UIView.animateWithDuration(self.duration, animations: { [unowned self] () in
            self.alpha = 1.0
        })
    }
    
    /**
    閉じる：非表示処理
    キューに残っているものがあれば非表示後それを表示
    */
    public func close() {
        self.timer?.invalidate()
        UIView.animateWithDuration(self.duration, animations: { [unowned self] () in
            self.alpha = 0.0
            }) { [weak self] (finished) in
                self?.removeFromSuperview()
                let alerts1 = Queue.alerts
                Queue.alerts = Queue.alerts.filter({ (alert) -> Bool in
                    return self != alert
                })
                let alerts2 = Queue.alerts
                // キューにもし何かあれば再表示
                if let alert = Queue.alerts.last {
                    alert.open()
                }
        }
    }
    
    /**
    アラートカラー
    */
    func alertColor(type: AlertType) -> UIColor {
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

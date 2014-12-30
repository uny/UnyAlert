UnyAlert
========

[SCLAlertView][1]をもう少し（自分にとって）使いやすく

[1]: <https://github.com/vikmeup/SCLAlertView-Swift>

プロジェクト化
-------

利用時はsubmoduleで（[Carthage][2]・Cocoapods対応も検討）

[2]: <https://github.com/Carthage/Carthage>

アイコンをcontentViewの中に
-------------------

![Success](<https://raw.githubusercontent.com/ynagai/UnyAlert/master/UnyAlertDemo/Success.png>)
![Error](<https://raw.githubusercontent.com/ynagai/UnyAlert/master/UnyAlertDemo/Error.png>)
![Warning](<https://raw.githubusercontent.com/ynagai/UnyAlert/master/UnyAlertDemo/Warning.png>)
![Info](<https://raw.githubusercontent.com/ynagai/UnyAlert/master/UnyAlertDemo/Info.png>)
![Loading](<https://raw.githubusercontent.com/ynagai/UnyAlert/master/UnyAlertDemo/Loading.png>)

フォントなどを変更できるように
---------------

ライブラリにて加えないと日本語フォントに対応できなかったので...

Appearance設定にも対応

キュー管理
-----

別インスタンスでアラート複数生成したら先勝ち→閉じたら新しい順に開く

（ただしタイマーで閉じる場合は非表示になってもタイマー止まらない）

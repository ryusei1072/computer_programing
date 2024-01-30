//
//  ViewController.swift
//  omoi
//
//  Created by 加藤隆聖 on 2024/01/27.
//
import UIKit

class ViewController: UIViewController {

    // Storyboardで接続するためのアウトレット
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期設定など
    }

    // ボタンがタップされた時のアクション
    @IBAction func postButtonTapped(_ sender: UIButton) {
        // テキストフィールドの内容をラベルに表示
        label.text = textField.text
    }
}

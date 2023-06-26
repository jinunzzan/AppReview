//
//  ViewController.swift
//  AppReview
//
//  Created by Eunchan Kim on 2023/06/26.
//

import UIKit

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.button)
        
        NSLayoutConstraint.activate([
          self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
          self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }

    @objc private func didTapButton(){
        //사용하는 쪽에서 버튼이 눌릴 경우 해당 유틸을 호출하여 사용합니당
        AppStoreReviewManager.requestReviewIfAppropriate()
    }

}


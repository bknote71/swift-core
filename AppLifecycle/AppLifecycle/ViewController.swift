//
//  ViewController.swift
//  AppLifecycle
//
//  Created by bknote71 on 8/2/24.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let text = UIButton()
    text.setTitle("Click!", for: .normal)
    text.backgroundColor = .systemGray
    text.addTarget(self, action: #selector(click), for: .touchUpInside)
    text.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(text)
    NSLayoutConstraint.activate([
      text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      text.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc
  func click() {
    print("click")
  }


}


//
//  ViewController.swift
//  Example
//
//  Created by craptone on 2021/11/13.
//

import UIKit
import NDTweetModal

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(NDTweetModal().text)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = NDTweetModalViewController()
        vc.modalPresentationStyle = .currentContext
        present(vc, animated: true, completion: nil)
    }


}


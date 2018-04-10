//
//  ViewController.swift
//  Rotatable
//
//  Created by susuyan on 2018/3/24.
//  Copyright © 2018年 susuyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @IBAction func rotateAction(_ sender: UIButton) {
        
        imageView.rotate()
        
    }
    
}


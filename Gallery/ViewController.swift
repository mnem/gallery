//
//  ViewController.swift
//  Gallery
//
//  Created by David Wagner on 21/03/2019.
//  Copyright © 2019 David Wagner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        install_handlers()
    }
    
    @IBAction func handleButton(_ sender: UIButton) {
        let images = image_name_list()
        print(images)
    }
    
}


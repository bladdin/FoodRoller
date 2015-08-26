//
//  HelpViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/26/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

  @IBOutlet weak var howToPlayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBarHidden = false
      howToPlayLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 26)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
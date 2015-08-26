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
  
  @IBOutlet weak var howToPlayTextView: UITextView!
  
  override func viewWillAppear(animated: Bool) {
    howToPlayTextView.text = "Last as long as you can without falling onto the cactuses.\n\nYou can jump from platforms or while in the air.  Jumping will cause you to drain your stamina, but landing on a platform will allow you to auto regenerate some stamina.\n\nTo jump, swipe anywhere on the screen in the opposite direction."
  }
  
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

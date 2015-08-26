//
//  SettingsViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/25/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var backgroundMusicLabel: UILabel!
  @IBOutlet weak var soundEffectLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBarHidden = false
      backgroundMusicLabel.text = "Background Music"
      soundEffectLabel.text = "Sound Effect"
      backgroundMusicLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 24)
      soundEffectLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 24)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

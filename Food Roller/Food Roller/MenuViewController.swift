//
//  MenuViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/24/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  let clickedStartButton = UIImage(named: "startClicked")
  let clickedSettingsButton = UIImage(named: "settingsClicked")
  let clickedHelpButton = UIImage(named: "helpClicked")
  
  @IBOutlet weak var startButtonOutlet: UIButton!
  @IBOutlet weak var settingsButtonOutlet: UIButton!
  @IBOutlet weak var helpButtonOutlet: UIButton!
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    startButtonOutlet.setImage(clickedStartButton, forState: UIControlState.Highlighted)
    settingsButtonOutlet.setImage(clickedSettingsButton, forState: UIControlState.Highlighted)
    helpButtonOutlet.setImage(clickedHelpButton, forState: UIControlState.Highlighted)


  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
       navigationController?.navigationBarHidden = true
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

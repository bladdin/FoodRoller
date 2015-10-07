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
    howToPlayTextView.text = "Last as long as you can without falling onto the cactuses, going too high, or falling too far behind.\n\nYou can jump from platforms or while in the air.  Jumping will cause you to drain your thumb stamina, but landing on a platform will allow you to rest your thumbs.\n\nTo jump, swipe anywhere on the screen in the opposite direction.\n\nGame created by Benjamin Laddin, Cathy Oun, Matthew Loh, Mark Lin.\nSpecial thanks to Brad Johnson and Nick McCardel of Code Fellows of Seattle\nCredit:\nArt by Shelly Oun and Ben Lin\nMusic by Benjamin TISSOT from Bensound.com\nSound effect Pain by thecheeseman from SoundBible.com\nSound effect Jump by snottyboy from SoundBible.com\nSound effect Squish Fart by timtube from SoundBible.com"
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBarHidden = false
      howToPlayLabel.font = UIFont(name: "ChalkboardSE-Regular", size: CGFloat(kHowToPlayLabelSize))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}

//
//  LottieViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/21/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    @IBOutlet weak var animationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.setAnimation(named: "day_of_the_dead_skull")
        animationView.loopAnimation = true
        animationView.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  OnBoardingContainerViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/24/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

class OnBoardingContainerViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "openOnBoarding", let destination = segue.destination as? OnBoardingViewController else {
            return
        }
        destination.pageControl = pageControl
    }

}

//
//  OnBoardingViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/24/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

struct OnBoardingItem {
    let title: String
    let description: String
    let imageName: String
}

class OnBoardingViewController: UIPageViewController {
    var pageControl: UIPageControl?
    
    fileprivate(set) lazy var items: [OnBoardingItem] = {
       return [
            OnBoardingItem(
                title: "Save money and reduce debt",
                description: "Press the start button",
                imageName: "OnBoarding1"
            ),
            OnBoardingItem(
                title: "You've finished your onboarding",
                description: "Press the start button",
                imageName: "OnBoarding2"
            )
        ]
    }()
    
    fileprivate(set) lazy var contentViewController: [UIViewController] = {
        var items = [UIViewController]()
        for i in 0..<self.items.count {
            items.append(instantiateViewController(i))
        }
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        pageControl?.numberOfPages = self.items.count
        updateContainerView(stepNumber: 0)
    }
    
    func instantiateViewController(_ index: Int) -> UIViewController {
        guard let viewController = UIStoryboard(name: "OnBoarding", bundle: Bundle.main).instantiateViewController(withIdentifier: "OnBoardingSteps") as? OnBoardingStepsViewController else {
            return UIViewController()
        }
        
        viewController.item = items[index]
        return viewController
    }
    
    func updateContainerView(stepNumber index: Int) {
        setViewControllers([contentViewController[index]], direction: .forward, animated: true, completion: nil)
    }
    
}

extension OnBoardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = contentViewController.index(of: viewController)
        if index == 0 {
            return nil
        }
        return contentViewController[index! - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = contentViewController.index(of: viewController)
        if index == contentViewController.count - 1 {
            return nil
        }
        return contentViewController[index! + 1]
    }
    
}

extension OnBoardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let index = contentViewController.index(of: viewControllers!.first!) else {
            return
        }
        pageControl?.currentPage = index
    }
}

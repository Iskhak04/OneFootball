//
//  MainTabBarController.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [setupVCs(viewController: ProfileModuleBuilder.build())]
    }
    
    private func setupVCs(viewController: UIViewController) -> UIViewController {
        viewController.tabBarItem.image = UIImage(systemName: "person.fill")
        viewController.tabBarItem.title = "Profile"
        return viewController
    }
}

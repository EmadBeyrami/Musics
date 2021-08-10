//
//  UINavigationController+RemoveAll.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func removeAllViewControllersAndPush(viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            CATransaction.begin()
            
            self.pushViewController(viewController, animated: animated)
            
            CATransaction.setCompletionBlock {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.removeOtherViewControllersFromStack()
                }
            }
            CATransaction.commit()
        }
    }
    
    func removeOtherViewControllersFromStack() {
        if self.viewControllers.count > 1 {
            self.viewControllers.removeFirst(self.viewControllers.count - 1)
            print("####### view controllers", self.viewControllers)
        }
    }
    
}

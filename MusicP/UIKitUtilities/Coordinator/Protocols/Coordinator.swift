//
//  Coordinator.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func navigateTo(deepLink: DeepLink)
    func start(animated: Bool)
    func finish()
}

extension Coordinator {
    
    func start() {
        start(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func navigateTo(deepLink: DeepLink) { }
    
    func finish() { }
}

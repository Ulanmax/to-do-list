//
//  AppCoordinator.swift
//  to-do-list
//
//  Created by Maks Niagolov on 05/04/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // Coordinate to launch the initial scene for Posts
    override func start() -> Observable<Void> {
        let toDoCoordinator = ToDoCoordinator(window: window)
        return coordinate(to: toDoCoordinator)
    }
    
}

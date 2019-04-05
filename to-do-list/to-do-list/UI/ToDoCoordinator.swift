//
//  ToDoCoordinator.swift
//  to-do-list
//
//  Created by Maks Niagolov on 05/04/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RealmSwift

class ToDoCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    var rootViewController:UIViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
}


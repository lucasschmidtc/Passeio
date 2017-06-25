//
//  UIViewController Extension.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 21/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import UIKit

extension UIViewController {
    var contents: UIViewController {
        if let navigationController = self as? UINavigationController {
            if let visibleController = navigationController.visibleViewController {
                return visibleController
            }
        }
        return self
    }
}

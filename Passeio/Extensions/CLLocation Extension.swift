//
//  CLLocation Extension.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 20/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    var latlon: String {
        return String(self.coordinate.latitude) + ", " + String(self.coordinate.longitude)
    }
}

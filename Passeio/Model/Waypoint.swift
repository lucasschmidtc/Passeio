//
//  Waypoint.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 19/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Waypoint: NSObject, MKAnnotation  {
    private var location: CLLocation
    private var position: CLLocationCoordinate2D
    private var time: Date
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    init(with location: CLLocation) {
        self.location = location
        self.position = location.coordinate
        self.time = location.timestamp
        super.init()
    }
    
    var original: CLLocation {
        get {
            return location
        }
    }
    
    var timestamp: Date {
        get {
            return time
        }
        set {
            time = newValue
        }
    }
    
    // MARK: - MKAnnotation Protocol
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return position
        }
        set {
            position = newValue
        }
    }
    
    var title: String? {
        get {
            return Waypoint.dateFormatter.string(from: location.timestamp)
        }
    }
    
    var subtitle: String? {
        get {
            return nil
        }
    }
}

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

class Waypoint: NSObject, MKAnnotation, NSCoding  {
    private var location: CLLocation
    private var latitude: Double
    private var longitude: Double
    private var time: Date
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    init(from location: CLLocation) {
        self.location = location
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.time = location.timestamp
        super.init()
    }
    
    // MARK: - Constants
    
    private struct Constants {
        struct CoderKey {
            static let location: String = "location"
            static let longitude: String = "longitude"
            static let latitude: String = "latitude"
            static let time: String = "time"
        }
    }
    
    // MARK: - NSCoding Protocol (Persistence)
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(location, forKey: Constants.CoderKey.location)
        aCoder.encode(latitude, forKey: Constants.CoderKey.latitude)
        aCoder.encode(longitude, forKey: Constants.CoderKey.longitude)
        aCoder.encode((time as NSDate), forKey: Constants.CoderKey.time)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        if let storedLocation = aDecoder.decodeObject(forKey: Constants.CoderKey.location) as? CLLocation {
            self.init(from: storedLocation)
            if aDecoder.containsValue(forKey: Constants.CoderKey.latitude),
                aDecoder.containsValue(forKey: Constants.CoderKey.longitude) {
                self.latitude = aDecoder.decodeDouble(forKey: Constants.CoderKey.latitude)
                self.longitude = aDecoder.decodeDouble(forKey: Constants.CoderKey.longitude)
            }
            
            if let storedTime = aDecoder.decodeObject(forKey: Constants.CoderKey.time) as? NSDate {
                self.time = (storedTime as Date)
            }
        } else {
            return nil
        }
    }
    
    // MARK: - Computed Properties
    
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
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
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

//
//  Track.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 19/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import CoreLocation

class Track {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    // TODO: make it private if possible
    var track = [[Waypoint]]()
    private lazy var geocoder = CLGeocoder()
    private var placemark: CLPlacemark?
    
    private var firstLocation: CLLocation? {
        get {
            return track.first?.first?.original
        }
    }
    
    private var timestamp: Date? {
        return firstLocation?.timestamp
    }
    
    private func setPlacemark() {
        if placemark == nil, count > 0 {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let location = self?.firstLocation {
                    self?.geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                        if error == nil {
                            DispatchQueue.main.async { [weak self] in
                                self?.placemark = placemarks?.first
                            }
                        }
                    }
                }
            }
        }
    }
    
    var count: Int {
        get {
            return track.reduce(0) {
                return $0 + $1.count
            }
        }
    }
    
    // MARK: - Description of the data, used to title the TableViewCells
    
    var title: String {
        get {
            if placemark == nil {
                setPlacemark()
            }
            
            let location = [placemark?.name, placemark?.subLocality, placemark?.locality,
                            placemark?.subAdministrativeArea, placemark?.administrativeArea,
                            placemark?.country, placemark?.inlandWater, placemark?.ocean,
                            track.first?.first?.original.latlon,
                            "Location not yet defined"].flatMap {$0}.first!
            
            return location
        }
    }
    
    var subtitle: String {
        get {
            var sub: String
            if count == 1 {
                sub = "1 observation"
            }
            else {
                sub = String(count) + " observations"
            }
            
            if timestamp != nil {
                sub = " since " + Track.dateFormatter.string(from: timestamp!)
            }
            
            return sub
        }
    }
}

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
    
    private lazy var geocoder = CLGeocoder()
    private var timestamp: Date?
    private var track = [[Waypoint]]() {
        didSet {
            if count > 0, placemark == nil {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    if let location = self?.track.first?.first?.original {
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
    }
    private var placemark: CLPlacemark?
    
    func addPoints(_ points: [Waypoint]) {
        track.append(points)
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
            let location = [placemark?.name, placemark?.subLocality, placemark?.locality, placemark?.subAdministrativeArea, placemark?.administrativeArea, placemark?.country, placemark?.inlandWater, placemark?.ocean, track.first?.first?.original.latlon, "Location not yet defined"].flatMap {$0}.first!
            
            if timestamp != nil {
                return location + " (" + Track.dateFormatter.string(from: timestamp!) + ")"
            }
            return location
        }
    }
    
    var subtitle: String {
        get {
            if count == 1 {
                return "1 observation"
            }
            return String(count) + " observations"
        }
    }
}

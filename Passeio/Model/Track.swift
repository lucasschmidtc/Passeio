//
//  Track.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 19/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import CoreLocation

class Track: NSObject, NSCoding {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    var segments = [[Waypoint]]()
    private lazy var geocoder = CLGeocoder()
    private var placemark: CLPlacemark?
    
    init(from locations: [CLLocation]) {
        super.init()
        addSegment(from: locations)
        setPlacemark()
    }
    
    init(from segments: [[Waypoint]]) {
        super.init()
        self.segments = segments
        setPlacemark()
    }
    
    init(from segments: [[Waypoint]], and placemark: CLPlacemark?) {
        super.init()
        self.segments = segments
        self.placemark = placemark
        if self.placemark == nil {
            setPlacemark()
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let placemarkKey: String = "placemark"
        static let segmentsKey: String = "segments"
    }
    
    // MARK: - NSCoding Protocol (Persistence)
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(placemark, forKey: Constants.placemarkKey)
        aCoder.encode(segments, forKey: Constants.segmentsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        if let storedSegments = aDecoder.decodeObject(forKey: Constants.segmentsKey) as? [[Waypoint]] {
            if let storedPlacemark = aDecoder.decodeObject(forKey: Constants.placemarkKey) as? CLPlacemark? {
                self.init(from: storedSegments, and: storedPlacemark)
            }
            else {
                self.init(from: storedSegments)
            }
        }
        else {
            return nil
        }
    }
    
    // MARK: - Handling of the data
    
    private var firstWaypoint: Waypoint? {
        get {
            return segments.first?.first
        }
    }
    
    private var timestamp: Date? {
        return firstWaypoint?.timestamp
    }
    
    private func setPlacemark() {
        if placemark == nil, count > 0 {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let location = self?.firstWaypoint?.original {
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
    
    func addSegment(from locations: [CLLocation]) {
        if locations.count > 0 {
            var waypoints = [Waypoint]()
            for location in locations {
                waypoints.append(Waypoint(from: location))
            }
            waypoints.sort { return $0.timestamp < $1.timestamp }
            segments.append(waypoints)
        }
    }
    
    var count: Int {
        get {
            return segments.reduce(0) {
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
                            firstWaypoint?.original.latlon, "Location not yet defined"].flatMap {$0}.first!
            
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
                sub = sub + " since " + Track.dateFormatter.string(from: timestamp!)
            }
            
            return sub
        }
    }
}

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
    }
    
    init(from segments: [[Waypoint]]) {
        super.init()
        self.segments = segments
    }
    
    init(from segments: [[Waypoint]], and placemark: CLPlacemark?) {
        super.init()
        self.segments = segments
        self.placemark = placemark
    }
    
    // MARK: - Constants
    
    private struct Constants {
        struct CoderKey {
            static let placemark: String = "placemark"
            static let segments: String = "segments"
        }
    }
    
    // MARK: - NSCoding Protocol (Persistence)
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(placemark, forKey: Constants.CoderKey.placemark)
        aCoder.encode(segments, forKey: Constants.CoderKey.segments)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        if let storedSegments = aDecoder.decodeObject(forKey: Constants.CoderKey.segments) as? [[Waypoint]] {
            if let storedPlacemark = aDecoder.decodeObject(forKey: Constants.CoderKey.placemark) as? CLPlacemark? {
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
                                NotificationCenter.default.post(name: .onPlacemarkSet, object: self)
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
            else {
                if let ocean = placemark?.ocean {
                    return ocean
                }
                else {
                    let location: [String] = [[placemark?.name,
                                               placemark?.subLocality,
                                               placemark?.locality, placemark?.inlandWater].flatMap {$0}.first!,
                                              [placemark?.subAdministrativeArea,
                                               placemark?.administrativeArea,
                                               placemark?.country].flatMap {$0}.first!].flatMap {$0}
                    
                    if location.count > 0 {
                        return location.joined(separator: ", ")
                    }
                }
            }
            
            return [firstWaypoint?.original.latlon, "Location not yet defined"].flatMap {$0}.first!
        }
    }
    
    var subtitle: String {
        get {
            var sub: String
            if count == 1 {
                sub = "1 location"
            }
            else {
                sub = String(count) + " locations"
            }
            
            if timestamp != nil {
                sub = sub + " recorded since " + Track.dateFormatter.string(from: timestamp!)
            }
            
            return sub
        }
    }
    
    // MARK: - GPX
    
    func generateXMLString() -> String {
        var xml = ""
        for segment in segments {
            xml += "\n        <trkseg>"
            for waypoint in segment {
                xml += "\n" + waypoint.generateXMLString()
            }
            xml += "\n        </trkseg>"
        }
        
        return xml
    }
}

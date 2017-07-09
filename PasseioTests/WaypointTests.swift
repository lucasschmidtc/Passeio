//
//  WaypointTests.swift
//  PasseioTests
//
//  Created by Lucas Cavalcante on 09/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Passeio

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocation: Equatable {
    public static func ==(lhs: CLLocation, rhs: CLLocation) -> Bool {
        return lhs.coordinate == rhs.coordinate &&
                lhs.timestamp == rhs.timestamp &&
                lhs.altitude == rhs.altitude &&
                lhs.horizontalAccuracy == rhs.horizontalAccuracy &&
                lhs.verticalAccuracy == rhs.verticalAccuracy
    }
}

extension Waypoint: Equatable {
    static func ==(lhs: Waypoint, rhs: Waypoint) -> Bool {
        return lhs.original == rhs.original &&
                lhs.coordinate == rhs.coordinate &&
                lhs.timestamp == rhs.timestamp
    }
}

class WaypointTests: XCTestCase {
    var waypoint: Waypoint!
    let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: -27.105, longitude: -109.360),
                              altitude: 13.0,
                              horizontalAccuracy: 5.9,
                              verticalAccuracy: 2.3,
                              timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 100)!))
    
    override func setUp() {
        super.setUp()
        waypoint = Waypoint(from: location)
    }
    
    override func tearDown() {
        waypoint = nil
        super.tearDown()
    }
    
    // tests encoding and decoding
    func testPersistence() {
        // encodes
        let waypointData = NSKeyedArchiver.archivedData(withRootObject: waypoint)
        // decodes
        let decodedWaypoint = NSKeyedUnarchiver.unarchiveObject(with: waypointData) as! Waypoint
        
        XCTAssertTrue(decodedWaypoint == waypoint)
    }
    
    // tests the timestamp of a Waypoint
    func testTimeStamp() {
        // tests the original timestamp
        XCTAssertEqual(waypoint.timestamp, location.timestamp)
        
        // updates the timestamp
        let newTimeStamp = Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 120)!)
        waypoint.timestamp = newTimeStamp
        
        // tests if the new timestamp was correctly set
        XCTAssertEqual(waypoint.timestamp, newTimeStamp)
        
        // tests if, after a timestamp change, the original one is still kept
        XCTAssertEqual(waypoint.original.timestamp, location.timestamp)
    }
    
    // tests the description (title and subtitle) of a Waypoint
    func testTitleAndSubtitle() {
        let title = waypoint.title
        let subtitle = waypoint.subtitle
        
        XCTAssertNotNil(title)
        XCTAssertEqual(title!, "Dec 31, 2000 at 10:01:40 PM")
        XCTAssertNil(subtitle, "Subtitle should be nil, currently there is no subtitle")
    }
    
    // tests the coordinate of a Waypoint
    func testCoordinate() {
        // tests the original coordinate
        XCTAssertEqual(waypoint.original.coordinate.latitude, location.coordinate.latitude)
        XCTAssertEqual(waypoint.original.coordinate.longitude, location.coordinate.longitude)
        
        // updates the coordinate
        let newCoordinate = CLLocationCoordinate2D(latitude: -28.1, longitude: -108.0)
        waypoint.coordinate = newCoordinate
        
        // tests if the new coordinate was correctly set
        XCTAssertEqual(waypoint.coordinate.latitude, newCoordinate.latitude)
        XCTAssertEqual(waypoint.coordinate.longitude, newCoordinate.longitude)
        
        // tests if, after a coordinate change, the original one is still kept
        XCTAssertEqual(waypoint.original.coordinate.latitude, location.coordinate.latitude)
        XCTAssertEqual(waypoint.original.coordinate.longitude, location.coordinate.longitude)
    }
    
    // tests the generation of the XML string (.gpx) from a Waypoint
    func testGenerateXMLString() {
        let isoFormatter = ISO8601DateFormatter()
        let generated = waypoint.generateXMLString()
        let expected =  """
                                    <trkpt lat="\(location.coordinate.latitude)" lon="\(location.coordinate.longitude)">
                                        <time>\(isoFormatter.string(from: location.timestamp))</time>
                                    </trkpt>
                        """
        
        XCTAssertEqual(generated, expected)
    }
}

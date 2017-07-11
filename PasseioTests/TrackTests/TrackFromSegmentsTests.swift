//
//  TrackFromSegmentsTests.swift
//  PasseioTests
//
//  Created by Lucas Cavalcante on 10/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Passeio

extension Track: Equatable {
    static func == (lhs: Track, rhs: Track) -> Bool {
        guard lhs.segments.count == rhs.segments.count else {
            return false
        }
        
        for i in 0..<lhs.segments.count {
            guard lhs.segments[i].count == rhs.segments[i].count else {
                return false
            }
            
            for j in 0..<lhs.segments[i].count {
                guard lhs.segments[i][j] == rhs.segments[i][j] else {
                    return false
                }
            }
        }
        
        return true
    }
}

class TrackFromSegmentsTests: XCTestCase {
    var track: Track!
    
    let locationA = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.33, longitude: -122.03),
                               altitude: 3.1,
                               horizontalAccuracy: 10.5,
                               verticalAccuracy: 10.5,
                               timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 304)!))
    let locationB = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.34, longitude: -122.04),
                               altitude: 2.9,
                               horizontalAccuracy: 7.5,
                               verticalAccuracy: 9.6,
                               timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 344)!))
    
    let locationC = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.34, longitude: -122.02),
                               altitude: 8.4,
                               horizontalAccuracy: 2.5,
                               verticalAccuracy: 11.6,
                               timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 380)!))
    
    override func setUp() {
        super.setUp()
        let segments = [[Waypoint(from: locationA), Waypoint(from: locationB)], [Waypoint(from: locationC)]]
        track = Track(from: segments)
    }
    
    override func tearDown() {
        track = nil
        super.tearDown()
    }
    
    // tests encoding and decoding
    func testPersistence() {
        // encodes
        let trackData = NSKeyedArchiver.archivedData(withRootObject: track)
        // decodes
        let decodedTrack = NSKeyedUnarchiver.unarchiveObject(with: trackData) as! Track
        
        XCTAssertTrue(decodedTrack == track)
    }
    
    // tests the generation of the XML string (.gpx) from a Track
    func testGenerateXMLString() {
        let generated = track.generateXMLString()
        let expected =  """
                        
                                <trkseg>
                                    <trkpt lat="37.33" lon="-122.03">
                                        <time>2001-01-01T00:05:04Z</time>
                                    </trkpt>
                                    <trkpt lat="37.34" lon="-122.04">
                                        <time>2001-01-01T00:05:44Z</time>
                                    </trkpt>
                                </trkseg>
                                <trkseg>
                                    <trkpt lat="37.34" lon="-122.02">
                                        <time>2001-01-01T00:06:20Z</time>
                                    </trkpt>
                                </trkseg>
                        """
        
        XCTAssertEqual(generated, expected)
    }
}

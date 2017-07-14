//
//  RecordingTests.swift
//  PasseioTests
//
//  Created by Lucas Cavalcante on 13/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Passeio

class RecordingTests: XCTestCase {
    var recording: Recording!
    let indexPath = NSIndexPath(row: 1, section: 0) as IndexPath
    
    let locationA = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.33, longitude: -122.03),
                               altitude: 3.1,
                               horizontalAccuracy: 10.5,
                               verticalAccuracy: 10.5,
                               timestamp: Date(timeIntervalSinceNow: 10))
    
    let locationB = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.34, longitude: -122.04),
                               altitude: 2.9,
                               horizontalAccuracy: 7.5,
                               verticalAccuracy: 9.6,
                               timestamp: Date(timeIntervalSinceNow: 20))
    
    let cachedLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 37.31, longitude: -122.02),
                                    altitude: 8.4,
                                    horizontalAccuracy: 2.5,
                                    verticalAccuracy: 11.6,
                                    timestamp: Date(timeIntervalSinceNow: -30))
    
    override func setUp() {
        super.setUp()
        recording = Recording(with: indexPath)
    }
    
    override func tearDown() {
        recording = nil
        super.tearDown()
    }
    
    // when it is a new recording there is no indexPath (nil)
    func testNilIndexPath() {
        let newRecording = Recording()
        XCTAssertNil(newRecording.indexPath)
    }
    
    // when it is a resume recording there is an indexPath to the TableViewCell
    func testIndexPath() {
        XCTAssertNotNil(recording.indexPath)
        XCTAssertEqual(recording.indexPath!, indexPath)
    }
    
    // ensures that cached locations (gathered before the start of the recording) are discarded
    func testRemoveCachedLocation() {
        let locations = [cachedLocation, locationA, locationB]
        recording.append(locations)
        XCTAssertEqual(recording.data, [locationA, locationB])
    }
    
    // ensures that the locations are added in a sorted manner (ascending in relation to the timestamp)
    func testSortedLocations() {
        let locations = [locationB, locationA]
        recording.append(locations)
        XCTAssertEqual(recording.data, [locationA, locationB])
    }
}

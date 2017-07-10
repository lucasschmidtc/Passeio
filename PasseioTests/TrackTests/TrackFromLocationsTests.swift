//
//  TrackFromLocationsTests.swift
//  PasseioTests
//
//  Created by Lucas Cavalcante on 09/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Passeio

class TrackFromLocationsTests: XCTestCase {
    var track: Track!
    let locations = [CLLocation(coordinate: CLLocationCoordinate2D(latitude: -27.105, longitude: -109.360),
                                altitude: 13.0,
                                horizontalAccuracy: 5.9,
                                verticalAccuracy: 2.3,
                                timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 100)!))]
    
    let newLocationA = CLLocation(coordinate: CLLocationCoordinate2D(latitude: -27.11, longitude: -109.37),
                                  altitude: 25.0,
                                  horizontalAccuracy: 7.8,
                                  verticalAccuracy: 3.6,
                                  timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 210)!))
    
    let newLocationB = CLLocation(coordinate: CLLocationCoordinate2D(latitude: -27.12, longitude: -109.36),
                                  altitude: 26.0,
                                  horizontalAccuracy: 7.5,
                                  verticalAccuracy: 3.7,
                                  timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 230)!))
    
    override func setUp() {
        super.setUp()
        track = Track(from: locations)
    }
    
    override func tearDown() {
        track = nil
        super.tearDown()
    }
    
    func testCount() {
        XCTAssertEqual(track.count, 1, "Track was initialized with 1 location.")
    }
    
    func testSubtitle() {
        XCTAssertEqual(track.subtitle, "1 location recorded since 12/31/00, 10:01 PM")
    }
    
    func testAddSegment() {
        track.addSegment(from: [newLocationA, newLocationB])
        
        XCTAssertEqual(track.count, 3)
        XCTAssertEqual(track.segments.count, 2, "There are 2 segments.")
        XCTAssertEqual(track.subtitle, "3 locations recorded since 12/31/00, 10:01 PM")
    }
    
    func testAddEmptySegment() {
        XCTAssertEqual(track.count, 1)
        XCTAssertEqual(track.segments.count, 1)
        // empty segments should not be added
        track.addSegment(from: [])
        XCTAssertEqual(track.count, 1)
        XCTAssertEqual(track.segments.count, 1)
    }
    
    // title depends on the placemark being lazily set
    func testPlacemarkAndTitle() {
        let promise = expectation(description: "Placemark is lazily set")
        NotificationCenter.default.addObserver(forName: Notification.Name.onPlacemarkSet,
                                               object: track,
                                               queue: OperationQueue.main,
                                               using: {
                                                notification in
                                                promise.fulfill()
                                                XCTAssertEqual(self.track.title, "Los Ríos, Valparaíso")})
        
        // initially the placemark is nil, thus the title is composed by the latitude and longitude (latlon extension)
        XCTAssertEqual(track.title, "\(locations.first!.coordinate.latitude), \(locations.first!.coordinate.longitude)")
        // if a title is requested and the placemark is nil, then the placemark will be fetched. After it is fetched
        // it sends a notification.
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testOceanPlacemarkAndTitle() {
        // similar to the previous test, but this time the location is set to the Pacific Ocean
        let promise = expectation(description: "Placemark is lazily set")
        let oceanLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: -8.78, longitude: -124.51),
                                       altitude: 0.0,
                                       horizontalAccuracy: 15.0,
                                       verticalAccuracy: 13.0,
                                       timestamp: Date(timeIntervalSinceReferenceDate: TimeInterval(exactly: 0)!))
        let oceanTrack = Track(from: [oceanLocation])
        
        NotificationCenter.default.addObserver(forName: Notification.Name.onPlacemarkSet,
                                               object: oceanTrack,
                                               queue: OperationQueue.main,
                                               using: {
                                                notification in
                                                promise.fulfill()
                                                XCTAssertEqual(oceanTrack.title, "South Pacific Ocean")})
        
        XCTAssertEqual(oceanTrack.title, "\(oceanLocation.coordinate.latitude), \(oceanLocation.coordinate.longitude)")
        waitForExpectations(timeout: 5, handler: nil)
    }
}

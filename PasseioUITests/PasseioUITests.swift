//
//  PasseioUITests.swift
//  PasseioUITests
//
//  Created by Lucas Cavalcante on 18/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Passeio

class PasseioUITests: XCTestCase {
    
    private func createTrack(from recording: Recorded) -> Track {
        func randomDouble() -> Double {
            return Double(arc4random_uniform(20))
        }
        
        let secondsBetweenSegments = 500.0
        let secondsBetweenLocations = 50.0
        
        var segments = [[Waypoint]]()
        var currentDate = recording.date
        for locations in recording.locations {
            var segment = [Waypoint]()
            for location in locations {
                segment.append(Waypoint(from: CLLocation(coordinate: location,
                                                         altitude: randomDouble(),
                                                         horizontalAccuracy: randomDouble(),
                                                         verticalAccuracy: randomDouble(),
                                                         timestamp: currentDate)))
                currentDate.addTimeInterval(secondsBetweenLocations)
            }
            segments.append(segment)
            currentDate.addTimeInterval(secondsBetweenSegments)
        }
        
        return Track(from: segments)
    }
 
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

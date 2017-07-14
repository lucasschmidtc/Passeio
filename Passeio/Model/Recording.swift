//
//  Segment.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 12/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import CoreLocation

// This class is used as a temporary storage for the CLLocations emitted by the CoreLocationManager. Once a recording
// is stopped its CLLocations are used to create a new track or to add a new segment to an existing one. Besides
// being a temporary storage, it also ensures that the CLLocations are valid (captured after the recording started;
// not a cached location) and that they are sorted (ascending order in relation to the time).

class Recording {
    private let startTime: Date
    private var index: IndexPath?
    private var locations = [CLLocation]()
    
    init() {
        startTime = Date.now
    }
    
    convenience init(with indexPath: IndexPath?) {
        self.init()
        index = indexPath
    }
    
    var data: [CLLocation] {
        get {
            return locations
        }
    }
    
    var indexPath: IndexPath? {
        get {
            return index
        }
    }
    
    func append(_ newLocations: [CLLocation]) {
        var toAdd = newLocations.filter { return $0.timestamp >= startTime }
        toAdd.sort { return $0.timestamp < $1.timestamp }
        locations.append(contentsOf: toAdd)
    }
}

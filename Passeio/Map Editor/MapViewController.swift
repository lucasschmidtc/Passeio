//
//  MapViewController.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 18/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var track: Track!
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .standard
            mapView.delegate = self
            
            if track != nil {
                for segment in track.segments {
                    // annotations pins
                    mapView.addAnnotations(segment)
                    mapView.showAnnotations(segment, animated: true)
                    
                    // a dashed line to show the recorded track
                    let dashedPolyline = MKPolyline(coordinates: segment.map { return $0.original.coordinate },
                                                    count: segment.count)
                    dashedPolyline.title = Constants.DashedLine.title
                    mapView.add(dashedPolyline)
                    
                    // a full line to show the modified track after dragging the pins around
                    let polyline = MKPolyline(coordinates: segment.map { return $0.coordinate },
                                              count: segment.count)
                    polyline.title = Constants.FullLine.title
                    mapView.add(polyline)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Constants
    
    private struct Constants {
        struct FullLine {
            static let title: String = "Modified Track"
            static let lineWidth: CGFloat = 4.0
            static let color: UIColor = UIColor.red
        }
        struct DashedLine {
            static let title: String = "Recorded Track"
            static let lineWidth: CGFloat = 3.0
            static let color: UIColor = UIColor.black
            static let pattern: [NSNumber] = [4, 8]
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: "Waypoint")
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Waypoint")
        } else {
            view.annotation = annotation
        }
        view.rightCalloutAccessoryView = nil
        view.leftCalloutAccessoryView = nil
        view.canShowCallout = true
        view.isDraggable = true
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let line = MKPolylineRenderer(overlay: overlay)
        if let title = overlay.title {
            if title == Constants.DashedLine.title {
                line.lineWidth = Constants.DashedLine.lineWidth
                line.strokeColor = Constants.DashedLine.color
                line.lineDashPattern = Constants.DashedLine.pattern
            }
            else if title == Constants.FullLine.title {
                line.lineWidth = Constants.FullLine.lineWidth
                line.strokeColor = Constants.FullLine.color
            }
        }
        return line
    }
    
    // whenever a pin is dragged the polyline that represents the current track is redraw
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 didChange newState: MKAnnotationViewDragState,
                 fromOldState oldState: MKAnnotationViewDragState) {
        
        switch newState {
        case .ending:
            updateModifiedTrack()
        default:
            break
        }
    }
    
    private func updateModifiedTrack() {
        // notifies an edit happened
        NotificationCenter.default.post(name: .onEdit, object: nil)
        
        // removes the old polyline
        let oldPolylines = (mapView.overlays).filter {
            if let title = $0.title {
                return title == Constants.FullLine.title
            }
            return false
        }
        mapView.removeOverlays(oldPolylines)
        
        if track != nil {
            for segment in track.segments {
                let polyline = MKPolyline(coordinates: segment.map { return $0.coordinate },
                                          count: segment.count)
                polyline.title = Constants.FullLine.title
                mapView.add(polyline)
            }
        }
    }
}

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
                    let dashedPolyline = MKPolyline(coordinates: segment.map {return $0.original.coordinate},
                                                    count: segment.count)
                    dashedPolyline.title = Constants.dashedLineTitle
                    mapView.add(dashedPolyline)
                    
                    // a full line to show the modified track after dragging the pins around
                    let polyline = MKPolyline(coordinates: segment.map {return $0.coordinate},
                                              count: segment.count)
                    polyline.title = Constants.fullLineTitle
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
        static let fullLineTitle: String = "Modified Track"
        static let fullLineWidth: CGFloat = 4.0
        static let fullLineColor: UIColor = UIColor.red
        static let dashedLineTitle: String = "Recorded Track"
        static let dashedLineWidth: CGFloat = 3.0
        static let dashedLineColor: UIColor = UIColor.black
        static let dashedLinePattern: [NSNumber] = [4, 8]
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
            if title == Constants.dashedLineTitle {
                line.lineWidth = Constants.dashedLineWidth
                line.strokeColor = Constants.dashedLineColor
                line.lineDashPattern = Constants.dashedLinePattern
            }
            else if title == Constants.fullLineTitle {
                line.lineWidth = Constants.fullLineWidth
                line.strokeColor = Constants.fullLineColor
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
        // removes the old polyline
        if let index = (mapView.overlays).index(where: {
            if let title = $0.title {
                return title == Constants.fullLineTitle
            }
            return false
        }) {
            mapView.remove(mapView.overlays[index])
        }
        
        if track != nil {
            for segment in track.segments {
                let polyline = MKPolyline(coordinates: segment.map {return $0.coordinate},
                                          count: segment.count)
                polyline.title = Constants.fullLineTitle
                mapView.add(polyline)
            }
        }
    }
}

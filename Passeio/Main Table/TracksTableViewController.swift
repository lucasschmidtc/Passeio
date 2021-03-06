//
//  PasseioTableViewController.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 18/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import UIKit
import CoreLocation

class TracksTableViewController: UITableViewController, UISplitViewControllerDelegate, CLLocationManagerDelegate {
    private var tracks = [Track]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        UserDefaults.standard.register(defaults: [Settings.Rate.Key: Settings.Rate.Default,
                                                  Settings.Accuracy.Key: Settings.Accuracy.Default])
        
        loadTracks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gets notified when the app moves to the background
        NotificationCenter.default.addObserver(forName: .UIApplicationWillResignActive,
                                               object: nil, 
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in self?.willResign() })
        
        // gets notified when an edit happens (drag a pin)
        NotificationCenter.default.addObserver(forName: .onEdit,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in self?.needsToSave = true })
        
        // gets notified when a placemark is defined
        NotificationCenter.default.addObserver(forName: .onPlacemarkSet,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in
                                                if let object = notification.object {
                                                    if let track = object as? Track {
                                                        self?.updateRow(of: track)
                                                    }
                                                }
                                                self?.needsToSave = true })
        
        // gets notified when a setting changes
        NotificationCenter.default.addObserver(forName: .onSettingsChange,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in self?.configureLocationManager() })
    }
    
    // MARK: - Constants
    
    private struct Constants {
        struct Cell {
            static let identifier: String = "Track Summary Cell"
        }
        struct Segue {
            static let mapEditor: String = "Map Editor"
        }
        static let tracksFileName: String = "tracks"
    }
    
    private let documentsURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    // MARK: - Persistence with NSCoding
    
    private var needsToSave = false
    private func willResign() {
        if needsToSave {
            saveTracks()
        }
    }
    
    private var tracksURL: URL {
        get {
            return documentsURL.appendingPathComponent(Constants.tracksFileName)
        }
    }
    
    private func saveTracks() {
        NSKeyedArchiver.archiveRootObject(tracks, toFile: tracksURL.path)
        needsToSave = false
    }
    
    private func loadTracks() {
        let stored = NSKeyedUnarchiver.unarchiveObject(withFile: tracksURL.path)
        if let stored = stored as? [Track] {
            tracks += stored
        }
    }
    
    // MARK: - Request for Location Services
    
    private var locationManager = CLLocationManager()
    private var recordingIsAllowed = true {
        didSet {
            if recordingIsAllowed {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            else {
                stopRecording()
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    private func requestAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            recordingIsAllowed = false
            alertRecordingIsNotAllowed()
        case .authorizedAlways, .authorizedWhenInUse:
            recordingIsAllowed = true
        }
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = UserDefaults.standard.double(forKey: Settings.Accuracy.Key)
        locationManager.distanceFilter = UserDefaults.standard.double(forKey: Settings.Rate.Key)
        locationManager.allowsBackgroundLocationUpdates = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            recordingIsAllowed = true
        default:
            recordingIsAllowed = false
        }
    }
    
    private func alertRecordingIsNotAllowed() {
        let alert = UIAlertController(title: "Location Access Not Allowed",
                                      message:  """
                                                This application requires location access in order
                                                to record your track. In order to grant it go to Settings,
                                                Privacy and then Location Services.
                                                """,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Initiate a Recording
    
    private var recording: Recording?
    private var currentlyRecording: Bool {
        get {
            if recording == nil {
                return false
            }
            return true
        }
    }
    
    private func record() {
        requestAuthorization()
        configureLocationManager()
        if recordingIsAllowed {
            startRecording()
        }
    }
    
    @IBAction func newRecording(_ sender: UIBarButtonItem) {
        recording = Recording()
        record()
    }
    
    private func resumeRecording(at indexPath: IndexPath) {
        recording = Recording(with: indexPath)
        record()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        recording!.append(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as NSError).code == CLError.denied.rawValue {
            stopRecording()
        }
    }
    
    private func startRecording() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause,
                                                                 target: self,
                                                                 action: #selector(self.stopRecording))
        locationManager.startUpdatingLocation()
    }
    
    @objc private func stopRecording() {
        if currentlyRecording {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                     target: self,
                                                                     action: #selector(self.newRecording(_:)))
            locationManager.stopUpdatingLocation()
            if let indexPath = recording!.indexPath {
                tracks[indexPath.row].addSegment(from: recording!.data)
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            else {
                tracks.insert(Track(from: recording!.data), at: 0)
                tableView.insertRows(at: [NSIndexPath(row: 0, section: 0) as IndexPath], with: .top)
            }
            
            recording = nil
            saveTracks()
        }
    }
    
    // MARK: - Table view data source

    @IBAction func refreshTable(_ sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    private func updateRow(of track: Track) {
        if let row = tracks.index(of: track) {
            let indexPath = NSIndexPath(row: row, section: 0)
            tableView.reloadRows(at: [indexPath as IndexPath], with: .none)
        }
    }
    
    private func deleteRow(at indexPath: IndexPath) {
        tracks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveTracks()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.identifier, for: indexPath)
        cell.textLabel?.text = tracks[indexPath.row].title
        cell.detailTextLabel?.text = tracks[indexPath.row].subtitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") {
            rowAction, indexPath in
            self.share(from: indexPath)
        }
        //shareAction.backgroundColor = UIColor(patternImage: <#T##UIImage#>)
        shareAction.backgroundColor = .green
        
        let resumeAction = UITableViewRowAction(style: .normal, title: "Resume") {
            rowAction, indexPath in
            self.resumeRecording(at: indexPath)
        }
        resumeAction.backgroundColor = .orange
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
            rowAction, indexPath in
            self.deleteRow(at: indexPath)
        }
        deleteAction.backgroundColor = .red
        
        if currentlyRecording {
            return [shareAction]
        }
        else {
            if recordingIsAllowed {
                return [deleteAction, resumeAction, shareAction]
            }
            return [deleteAction, shareAction]
        }
    }
    
    // MARK: - Share/Export
    
    private func generateXMLString(from track: Track) -> String {
        var xml =   """
                    <?xml version="1.0" encoding="UTF-8"?>
                    <gpx xmlns="http://www.topografix.com/GPX/1/1"
                        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                        xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd"
                        version="1.1"
                        creator="Passeio">
                        <metadata>
                            <link href="https://github.com/lucasschmidtc/Passeio">
                                <text>Passeio</text>
                            </link>
                            <time>\(Date.GPXFormatter.string(from: Date.now))</time>
                        </metadata>
                        <trk>
                            <name>\(track.title)</name>
                    """
        xml += track.generateXMLString() + "\n"
        xml +=  """
                    </trk>
                </gpx>
                """
        return xml
    }
    
    private func share(from indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        let xml = generateXMLString(from: track)
        
        let fileURL = documentsURL.appendingPathComponent("\(track.title).gpx")
        if (try? xml.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)) != nil {
            let activityViewController = UIActivityViewController(activityItems: [fileURL],
                                                                  applicationActivities: nil)
            
            activityViewController.completionWithItemsHandler = {
                (activityType, completed, returnedItems, error) in
                try? FileManager.default.removeItem(at: fileURL)
            }
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceRect = tableView.rectForRow(at: indexPath)
                popoverPresentationController.sourceView = tableView
            }
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.mapEditor {
            if let controller = segue.destination.contents as? MapViewController {
                if let selectedIndex = tableView.indexPathForSelectedRow {
                    controller.track = tracks[selectedIndex.row]
                }
            }
        }
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        
        if primaryViewController.contents == self {
            if let mapViewController = secondaryViewController.contents as? MapViewController {
                if mapViewController.track == nil {
                    return true
                }
            }
        }
        
        return false
    }
}

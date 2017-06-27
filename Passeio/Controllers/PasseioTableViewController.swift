//
//  PasseioTableViewController.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 18/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import UIKit
import CoreLocation

class PasseioTableViewController: UITableViewController, UISplitViewControllerDelegate, CLLocationManagerDelegate {
    private var tracks = [Track]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        loadTracks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get notified when the app moves to the background
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillResignActive,
                                               object: nil, 
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in self?.willResign() })
        
        // get notified when an edit happens (drag a pin)
        NotificationCenter.default.addObserver(forName: .onEdit,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in self?.needsToSave = true })
        
        // get notified when a placemark is defined
        NotificationCenter.default.addObserver(forName: .onPlacemarkSet,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: { [weak self] notification in self?.needsToSave = true })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Constants
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("tracks")
    
    private struct Constants {
        static let summaryCellIdentifier: String = "Track Summary Cell"
        static let mapEditorSegueIdentfier: String = "Map Editor"
    }
    
    // MARK: - Persistence with NSCoding
    
    private var needsToSave = false
    private func willResign() {
        if needsToSave {
            saveTracks()
        }
    }
    
    private func saveTracks() {
        NSKeyedArchiver.archiveRootObject(tracks, toFile: PasseioTableViewController.archiveURL.path)
        needsToSave = false
    }
    
    private func loadTracks() {
        let stored = NSKeyedUnarchiver.unarchiveObject(withFile: PasseioTableViewController.archiveURL.path)
        if let stored = stored as? [Track] {
            tracks += stored
        }
    }
    
    // MARK: - Request for Location Services
    
    private var locationManager = CLLocationManager()
    private var recordingIsAllowed: Bool? {
        didSet {
            if recordingIsAllowed == false {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.allowsBackgroundLocationUpdates = false
        
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            recordingIsAllowed = true
        default:
            stopRecording()
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
    
    private var currentlyRecording = false
    @IBAction func record(_ sender: UIBarButtonItem) {
        configureLocationManager()
        if recordingIsAllowed != nil, recordingIsAllowed! == true {
            if currentlyRecording {
                stopRecording()
            }
            else {
                startRecording()
            }
        }
    }
    
    private var locations = [CLLocation]()
    private var startedRecordingTimestamp: Date?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startedRecordingTimestamp != nil {
            self.locations.append(contentsOf: locations.filter { return $0.timestamp >= startedRecordingTimestamp! })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as NSError).code == CLError.denied.rawValue {
            stopRecording()
        }
    }
    
    private func startRecording() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause,
                                                                 target: self,
                                                                 action: #selector(self.record(_:)))
        currentlyRecording = true
        locations.removeAll()
        startedRecordingTimestamp = Date(timeIntervalSinceNow: 0)
        locationManager.startUpdatingLocation()
    }
    
    private func stopRecording() {
        if currentlyRecording {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                     target: self,
                                                                     action: #selector(self.record(_:)))
            locationManager.stopUpdatingLocation()
            tracks.insert(Track(from: locations), at: 0)
            tableView.insertRows(at: [NSIndexPath(row: 0, section: 0) as IndexPath], with: .top)
            currentlyRecording = false
            startedRecordingTimestamp = nil
            saveTracks()
        }
    }
    
    // MARK: - Table view data source

    @IBAction func refreshTable(_ sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.summaryCellIdentifier, for: indexPath)
        cell.textLabel?.text = tracks[indexPath.row].title
        cell.detailTextLabel?.text = tracks[indexPath.row].subtitle

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.mapEditorSegueIdentfier {
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

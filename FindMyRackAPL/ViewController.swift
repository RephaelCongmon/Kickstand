//
//  ViewController.swift
//  FindMyRackAPL
//
//  Created by Abhi Ravi on 3/2/19.
//  Copyright © 2019 Abhi Ravi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        createAnnotations(locations: annotationLocations)
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        
        print(locationManager.location?.coordinate as Any)
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    //marker data
    let annotationLocations = [
        ["title": "Will Skelton Greenway", "rackType":"hoop", "address": "2225 Estelle Circle", "latitude":35.961614, "longitude": -83.882901],
        
        ["title": "Ned McWheter Park", "rackType":"hoop", "address": "1648 Riverside", "latitude":35.963440, "longitude": -83.896666],
        
        ["title": "Burlington Branch Library", "rackType":"hoop", "address": "4614 Asheville Hwy", "latitude":36.004390, "longitude": -83.859357],
    ]
    
    //adding markers to map
    func createAnnotations(locations: [[String : Any]]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            
            mapView.addAnnotation(annotations)
        }
    }
    
    func findClosestRack(locations: [[String : Any]] ) {
        
        for location in locations {
            
            let coordinate0 = CLLocation(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            
            let coordinate1 = CLLocation(latitude: 5.0, longitude: 3.0)
            
            let distanceInMeters = coordinate0.distance(from: coordinate1)
            
        }
    
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }


    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


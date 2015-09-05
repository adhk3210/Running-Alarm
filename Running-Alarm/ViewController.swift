//
//  ViewController.swift
//  Running-Alarm
//
//  Created by Edward Yoo on 9/5/15.
//  Copyright (c) 2015 Hohun Yoo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var cycle = 0
    var startingPoint = CLLocation(latitude: 0, longitude: 0)

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
       
        var latitude: Double = location.coordinate.latitude
        var longitude: Double = location.coordinate.longitude
        
        var coordinates: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        self.mapView.setRegion(region, animated: true)
        cycle++
        
        if cycle == 1 {
            startingPoint = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            println("Starting Location: \(startingPoint.coordinate.latitude), \(startingPoint.coordinate.longitude)")
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: startingPoint.coordinate.latitude, longitude: startingPoint.coordinate.longitude)
            self.mapView.addAnnotation(annotation)
        }
        
        var distance = (startingPoint.distanceFromLocation(coordinates) * 0.000621371)
        
        println("Distance: \(distance)")
        
        if distance >= 0.1 {
            self.locationManager.stopUpdatingLocation()
        }
        
        println("current location: \(latitude), \(longitude)")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error: " + error.localizedDescription)
    }
    
}


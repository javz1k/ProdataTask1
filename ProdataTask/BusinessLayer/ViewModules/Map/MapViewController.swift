//
//  MapViewController.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 05.04.24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var vm = MapViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addCafeAnnotation()
        setupManager()
//        startLocationUpdates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        checkLocationServicesStatus() 
    }
    
    func setupManager(){
        vm.locationManager.delegate = self
        vm.locationManager.requestWhenInUseAuthorization()
        vm.locationManager.startUpdatingLocation()
        vm.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
    }
    
//    func checkLocationServicesStatus() {
//        let status = CLLocationManager.authorizationStatus()
//        
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            print("Location services are enabled for the app")
//            mapView.showsUserLocation = true
//            vm.locationManager.startUpdatingLocation()
//            
//        case .denied, .restricted:
//            print("Location services are disabled for the app")
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: "Location is enabled", message: "Turn on!", preferredStyle: .alert)
//                let settingsAction = UIAlertAction(title: "Settings", style: .default) { alert in
//                    if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                
//                alert.addAction(settingsAction)
//                alert.addAction(cancelAction)
//                self.present(alert, animated: true, completion: nil)
//            }
//        case .notDetermined:
//            print("Location services authorization status not determined")
//            vm.locationManager.requestWhenInUseAuthorization()
//            // Location services authorization status is not determined yet, you may request authorization
//        @unknown default:
//            print("Unknown location services authorization status")
//        }
//    }



   

    
    func addCafeAnnotation() {
        guard let cafe = vm.cafe, let cafeLat = cafe.cafeLat, let cafeLong = cafe.cafeLong else {
            return // Handle the case where cafe data or coordinates are not available
        }
        
        let annotation = MKPointAnnotation()
        annotation.title = cafe.cafeName
        annotation.coordinate = CLLocationCoordinate2D(latitude: cafeLat, longitude: cafeLong)
        
        // Add the annotation to the map
        mapView.addAnnotation(annotation)
        
        // Set the region of the map view centered around the cafe's coordinates
        let regionRadius: CLLocationDistance = 2000 // Adjust as needed
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        annotationView.canShowCallout = true
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        guard let cafeURLString = vm.cafe?.cafeURL else { return }
        
        let webVC = WebViewController()
        webVC.urlString = cafeURLString // Pass the URL to the WebViewController
        navigationController?.pushViewController(webVC, animated: true)

//        present(webVC, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        
    }
   
    
    ////////////////////////
//    func startLocationUpdates() {
//        guard CLLocationManager.locationServicesEnabled() else {
//            print("Location services are not enabled")
//            return
//        }
//        
//        guard let locationManager = vm.locationManager else {
//            print("Location manager is not initialized")
//            return
//        }
//        
//        // Check authorization status
//        switch locationManager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            // Start updating location
//            locationManager.startUpdatingLocation()
//            
//            // Schedule timer to update location every 30 seconds
//            Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [self] timer in
//                vm.locationManager?.requestLocation()
//            }
//        case .notDetermined:
//            // Authorization status not determined yet, wait for user's response
//            locationManager.requestWhenInUseAuthorization()
//        case .denied, .restricted:
//            // Location access denied or restricted
//            print("Location access denied or restricted")
//            // You can prompt the user to enable location services from settings
//        @unknown default:
//            // Handle any future authorization status
//            print("Unhandled authorization status")
//        }
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            // Start location updates if authorized
//            startLocationUpdates()
//        default:
//            // Handle other cases if needed
//            break
//        }
//    }
//
//
//        
//        // MARK: - CLLocationManagerDelegate
//        
//        // Handle updated user location
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            guard let newLocation = locations.last else { return }
//            
//            // Update user location
//            vm.userLocation = newLocation
//            
//            // Update map with user's location
//            updateMap()
//        }
//        
//        // Handle location update error
//        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//            print("Location manager error: \(error.localizedDescription)")
//        }
//        
//        // Function to update map with user's location
//        func updateMap() {
//            guard let userLocation = vm.userLocation, let cafeAnnotation = vm.cafeAnnotation else {
//                return // User location or cafe annotation not available
//            }
//            
//            // Calculate distance between user and cafe
//            let distance = userLocation.distance(from: CLLocation(latitude: cafeAnnotation.coordinate.latitude, longitude: cafeAnnotation.coordinate.longitude))
//            
//            print("Distance to cafe: \(distance) meters")
//            
//            // Update map region to show both user and cafe locations
//            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//            mapView.setRegion(region, animated: true)
//        }

}

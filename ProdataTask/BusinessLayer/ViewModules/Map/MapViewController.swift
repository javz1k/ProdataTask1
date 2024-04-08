//
//  MapViewController.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 05.04.24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    var vm = MapViewModel.shared
    let webVC = WebViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCafeAnnotation()
        setupManager()
        checklocationServices()
    }
    
    func setupManager(){
        //MapView config
        mapView.delegate = self

        //Location manager config
        vm.locationManager.delegate = self
        vm.locationManager.requestAlwaysAuthorization()
        vm.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        vm.locationManager.startUpdatingLocation()
    }
    
}

extension MapViewController:MKMapViewDelegate{
    
    func addCafeAnnotation() {
        guard let cafe = vm.cafe, let cafeLat = cafe.cafeLat, let cafeLong = cafe.cafeLong else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.title = cafe.cafeName
        annotation.coordinate = CLLocationCoordinate2D(latitude: cafeLat, longitude: cafeLong)
        mapView.addAnnotation(annotation)
        let regionRadius: CLLocationDistance = 2000
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
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController ?? WebViewController()
        vc.urlString = cafeURLString
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapViewController:CLLocationManagerDelegate{
    func checklocationServices() {
        DispatchQueue.global(qos: .background).async {
            if CLLocationManager.locationServicesEnabled() {
                print("Location services are enabled")
                self.checkLocationAuthorization()
            } else {
                print("Location services are not enabled")
            }
        }
    }

    func checkLocationAuthorization() {
        let locationManager = vm.locationManager
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async {
                self.mapView.showsUserLocation = true
            }
        case .denied, .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
}




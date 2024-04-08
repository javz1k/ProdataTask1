//
//  MapViewModel.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 05.04.24.
//

import Foundation
import CoreLocation
import MapKit

final class MapViewModel {
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var cafeAnnotation: MKPointAnnotation?
    var cafe: CafeModel?

    
    static let shared = MapViewModel()
    private init() {
     
    }
}

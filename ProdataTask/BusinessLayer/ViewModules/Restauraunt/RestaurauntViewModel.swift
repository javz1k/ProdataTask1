//
//  RestaurauntViewModel.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 05.04.24.
//

import Foundation
import RealmSwift

final class RestaurauntViewModel {
    
    let realm = RealmHelper.instance
    var mapVM = MapViewModel.shared
    var cafeArray: Results<CafeModel>?
    var cafeData: CafeModel?
    static let shared: RestaurauntViewModel = RestaurauntViewModel()
    
    private init() {
        self.cafeArray = realm.getCafe()
    }
}

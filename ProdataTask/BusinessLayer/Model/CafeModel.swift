//
//  CafeModel.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 07.04.24.
//

import Foundation
import RealmSwift

class CafeModel:Object {
    
    @Persisted(primaryKey: true) var cafeID:String = UUID().uuidString
    @Persisted var cafeName:String?
    @Persisted var cafeURL:String?
    @Persisted var cafeLong:Double?
    @Persisted var cafeLat:Double?
    
}

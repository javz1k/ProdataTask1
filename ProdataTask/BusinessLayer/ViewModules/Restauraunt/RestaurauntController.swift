//
//  RestaurauntController.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 05.04.24.
//

import UIKit
import RealmSwift

class RestaurauntController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    let vm = RestaurauntViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        collectionView.registerNib(with: "RestaurantCell")
        print(vm.realm.getFileUrl())
    }
    
    fileprivate func showMapController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController ?? MapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension RestaurauntController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return vm.cafeArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellClass: RestaurantCell.self, indexPath: indexPath)
        cell.configureCell(title: vm.cafeArray?[indexPath.row].cafeName ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        vm.mapVM.cafe = vm.cafeArray?[indexPath.row]
        showMapController()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.width ,
            height: collectionView.frame.height*0.1)
    }
    
    
}

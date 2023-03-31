//
//  CategoryCVC.swift
//  MarketMall
//
//  Created by Ваня Науменко on 30.03.23.
//

import UIKit

class CategoryCVC: UICollectionViewController {

    //MARK: Vars
    var categoryArray: [Category] = []
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadCategories()
    }
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCVCell
        cell.generateCell(categoryArray[indexPath.row])
        
        return cell
    }
    
    
    //MARK: Douwload categories
    
    private func loadCategories() {
        downloadCategoryiesFromFirebase { (allCategories) in
            self.categoryArray = allCategories
            self.collectionView.reloadData()
        }
    }

}

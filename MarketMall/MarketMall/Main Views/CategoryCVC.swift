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
    
    private let sectionInsert = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    private var itemPerRow: CGFloat = 3
    
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
    
    //MARK: UIControllerDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "categoryToItemSeg", sender: categoryArray[indexPath.row] )
    }
    
    //MARK: Douwload categories
    
    private func loadCategories() {
        downloadCategoryiesFromFirebase { (allCategories) in
            self.categoryArray = allCategories
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToItemSeg" {
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category
        }
    }
    

}


extension CategoryCVC: UICollectionViewDelegateFlowLayout {
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let paddingSpace = sectionInsert.left * (itemPerRow + 1)
       let availableWidth = view.frame.width - paddingSpace
       let withPerItem = availableWidth / itemPerRow
       
       return CGSize(width: withPerItem, height: withPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsert
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsert.left
    }
}

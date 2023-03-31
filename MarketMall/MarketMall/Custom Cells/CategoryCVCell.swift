//
//  CategoryCVCell.swift
//  MarketMall
//
//  Created by Ваня Науменко on 30.03.23.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func generateCell(_ category: Category) {
        
        nameLabel.text = category.name
        imageView.image = category.image
    }
}

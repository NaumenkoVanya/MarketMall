//
//  ItemViewController.swift
//  MarketMall
//
//  Created by Ваня Науменко on 2.05.23.
//

import UIKit
import JGProgressHUD

class ItemViewController: UIViewController {
    //MARK: IBOutlets
    
    @IBOutlet weak var imageCollectionView: UICollectionViewCell!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: Vars
    var item: Item!
    var itemImage: [UIImage] = []
    let hub = JGProgressHUD(style: .dark)
    //MARK: ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Item Name is", item.name)
    }
   
}

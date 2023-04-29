//
//  Item.swift
//  MarketMall
//
//  Created by Ваня Науменко on 24.04.23.
//

import Foundation
import UIKit

// MARK: - Item

class Item {
    var id: String!
    var categoryId: String!
    var name: String!
    var description: String!
    var price: Double!
    var imageLinks: [String]!

    init() {}

    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as? String
        categoryId = _dictionary[kCATEGORYID] as? String
        name = _dictionary[kNAME] as? String
        description = _dictionary[kDESCRIPTION] as? String
        price = _dictionary[kPRICE] as? Double
        imageLinks = _dictionary[kIMAGELINKS] as? [String]
    }
}

// MARK: Save items func

func saveItemToFirestore(_ item: Item) {
    
    FirebaseReference(.Items).document(item.id).setData(itemDictionaryFrom(item) as! [String: Any])
    
}

// MARK: Helpers functions

func itemDictionaryFrom(_ item: Item) -> NSDictionary {
    return NSDictionary(objects: [item.id, item.categoryId, item.name, item.description, item.price, item.imageLinks], forKeys: [kOBJECTID as NSCopying, kCATEGORYID as NSCopying, kNAME as NSCopying, kDESCRIPTION as NSCopying, kPRICE as NSCopying, kIMAGELINKS as NSCopying])
}


//MARK: Dowload Func
func dowloadItemsFromFirebase(_ withCategoryId: String, completion: @escaping (_ itemArray: [Item]) -> Void){
    
    var itemArray: [Item] = []
    FirebaseReference(.Items).whereField(kCATEGORYID, isEqualTo:  withCategoryId).getDocuments{(snapShot, error) in
        
        guard let snapshot = snapShot else {
            completion(itemArray)
            return
        }
        
        if !snapshot.isEmpty {
            for itemDict in snapshot.documents {
                itemArray.append(Item(_dictionary: itemDict.data() as NSDictionary))
            }
        }
        
        completion(itemArray)
        
    }
}

//
//  FirebaseCollectionReference.swift
//  MarketMall
//
//  Created by Ваня Науменко on 31.03.23.
//

import FirebaseFirestore
import Foundation

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}

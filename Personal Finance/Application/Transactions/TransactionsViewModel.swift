//
//  TransactionsViewModel.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/20/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Core

class TransactionsViewModel {
    private var items: [Core.Transaction] = []
    private var db: Firestore {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.isPersistenceEnabled = true
        db.settings = settings
        return db
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    init() {
        db.collection("transactions").getDocuments {[weak self] (snapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.items.removeAll()
            
            try? snapshot?.documents.forEach({ (snapshot) in
                let json = snapshot.data()
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                guard let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData) else {
                    return
                }
                
                transaction.firebaseId = snapshot.documentID
                self.items.append(transaction)
            })
        }
    }
}

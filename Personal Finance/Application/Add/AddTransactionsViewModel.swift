//
//  AddTransactionsViewModel.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/21/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Core

class AddTransactionsViewModel {
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    func add(name: String, description: String, value: String) {
        guard let value = Float(value) else {
            return
        }
        
        let transaction = Core.Transaction(
            value: value,
            category: .expend,
            name: name,
            date: Date()
        )
        
        guard let data = transaction.data() else {
            return
        }
        
        db.collection("transactions").addDocument(data: data)
    }
}

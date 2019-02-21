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

protocol TransactionsViewModelDelegate {
    func didLoadData()
}

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
    
    var delegate: TransactionsViewModelDelegate?
    
    init() {
        db.collection("transactions").order(by: "date", descending: true)
            .addSnapshotListener {[weak self] (snapshot, error) in
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
            
            self.delegate?.didLoadData()
        }
    }
    
    func item(at indexPath: IndexPath) -> TransactionViewModel {
        return TransactionViewModel(transaction: items[indexPath.row])
    }
}

class TransactionViewModel {
    private var transaction: Core.Transaction
    
    var name: String {
        return transaction.name
    }
    
    var value: String {
        return transaction.value.currency()
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: transaction.date)
    }
    
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: transaction.date)
    }
    
    init(transaction: Core.Transaction) {
        self.transaction = transaction
    }
}

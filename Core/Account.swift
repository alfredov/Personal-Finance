import Foundation

public class Account {
    var name: String
    var value: Float
    var transactions: [Transaction]
    
    public init(name: String, value: Float) {
        self.name = name
        self.value = value
        self.transactions = []
    }
    
    public func add(transaction: Transaction) {
        transactions.append(transaction)
        
        switch transaction.category {
        case .earn:
            value += transaction.value
        case .expend:
            value -= transaction.value
        }
    }
    
    public func remove(transaction: Transaction) {
        guard let index = transactions.firstIndex(of: transaction) else {
            return
        }
        transactions.remove(at: index)
    }
}

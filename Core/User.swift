import Foundation

public struct User {
    var name: String
    var lastName: String
    var accounts: [Account]
    var budgets: [Budget]
    
    public var actives: Float {
        return accounts.reduce(0, { $0 + $1.value })
    }
    
    public init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
        self.accounts = []
        self.budgets = []
    }
    
    public mutating func add(account: Account) {
        accounts.append(account)
    }
    
    public mutating func add(budget: Budget) {
        budgets.append(budget)
    }
    
    public func budget(for category: BudgetCategory) -> Budget? {
        return budgets.first(where: { $0.category == category })
    }
}

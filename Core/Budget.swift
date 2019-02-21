import Foundation

public enum BudgetCategory {
    case none, rent, food, groseries, tax, services, car, baby, care, healt, medical
}

public class Budget {
    var category: BudgetCategory
    var value: Float
    
    init(category: BudgetCategory, value: Float) {
        self.category = category
        self.value = value
    }
}

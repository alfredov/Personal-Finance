import Foundation

public enum TransactionCategory: Int {
    case earn, expend
}

extension TransactionCategory: Codable {}

public class Transaction: Codable {
    var uuid = UUID()
    var value: Float
    var category: TransactionCategory
    var name: String
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case value
        case category
        case name
        case date
    }
    
    public init(value: Float, category: TransactionCategory, name: String, date: Date) {
        self.value = value
        self.category = category
        self.name = name
        self.date = date
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uuid = try container.decode(UUID.self, forKey: .uuid)
        value = try container.decode(Float.self, forKey: .value)
        category = try container.decode(TransactionCategory.self, forKey: .category)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
    }
    
    public func data() -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(self) else {
            return nil
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        return json
    }
}

extension Transaction: Hashable {
    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    public var hashValue: Int {
        return uuid.hashValue
    }
}

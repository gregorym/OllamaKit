public struct OKCompletionOptions: Encodable {
    private var options: [String: Any] = [:]
    
    public init() {}

    public mutating func setOption(key: String, value: Any) {
        options[key] = value
    }
    
    public func getOption<T>(key: String) -> T? {
        return options[key] as? T
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        for (key, value) in options {
            if let val = value as? Int {
                try container.encode(val, forKey: DynamicCodingKeys(stringValue: key)!)
            } else if let val = value as? String {
                try container.encode(val, forKey: DynamicCodingKeys(stringValue: key)!)
            } else if let val = value as? Float {
                try container.encode(val, forKey: DynamicCodingKeys(stringValue: key)!)
            } else {
                // Handle or ignore other types
                print("Unsupported type for \(key)")
            }
        }
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
}

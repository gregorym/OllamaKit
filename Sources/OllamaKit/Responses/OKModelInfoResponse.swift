//
//  OKModelInfoResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

public enum JSONValue: Codable, Hashable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case null

    // MARK: - Decoding

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
        } else if let b = try? container.decode(Bool.self) {
            self = .bool(b)
        } else if let i = try? container.decode(Int.self) {
            self = .int(i)
        } else if let d = try? container.decode(Double.self) {
            self = .double(d)
        } else if let s = try? container.decode(String.self) {
            self = .string(s)
        } else {
            throw DecodingError.typeMismatch(
                JSONValue.self,
                .init(codingPath: container.codingPath,
                      debugDescription: "Unsupported JSON primitive")
            )
        }
    }

    // MARK: - Encoding

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let s):  try container.encode(s)
        case .int(let i):     try container.encode(i)
        case .double(let d):  try container.encode(d)
        case .bool(let b):    try container.encode(b)
        case .null:           try container.encodeNil()
        }
    }

    /// Returns the associated `Int` if the value is an `.int`,
    /// tries to convert from `.double` or numeric `String`,
    /// otherwise `nil`.
    var intValue: Int? {
        switch self {
        case .int(let n):         return n
        case .double(let d):      return Int(d)
        case .string(let s):      return Int(s)
        default:                  return nil
        }
    }
    
    /// Returns the associated `Double` or converts from `Int` / numeric `String`.
    var doubleValue: Double? {
        switch self {
        case .double(let d):      return d
        case .int(let n):         return Double(n)
        case .string(let s):      return Double(s)
        default:                  return nil
        }
    }
    
    /// Returns the associated `String`, or stringifies a primitive.
    var stringValue: String? {
        switch self {
        case .string(let s):      return s
        case .int(let n):         return String(n)
        case .double(let d):      return String(d)
        case .bool(let b):        return String(b)
        case .null:               return nil
        }
    }
    
    /// Returns the associated `Bool`, or parses `"true"/"false"` (case-insensitive).
    var boolValue: Bool? {
        switch self {
        case .bool(let b):        return b
        case .string(let s):
            switch s.lowercased() {
            case "true":  return true
            case "false": return false
            default:      return nil
            }
        default:                  return nil
        }
    }
}

/// A structure that represents the response containing information about a specific model from the Ollama API.
public struct OKModelInfoResponse: Decodable {
    /// A string detailing the licensing information for the model.
    public let license: String
    
    /// A string representing the template used by the model.
    public let template: String
    
    /// A string containing the path or identifier of the model file.
    public let modelfile: String
    
    /// A string detailing the parameters or settings of the model.
    public let parameters: String

    // A list of capabilities
    public let capabilities: [String]

    /// Arbitrary key/value pairs giving detailed model metadata
    /// (`model_info` in the JSON). Values may be numbers, bools,
    /// strings, or `null`, so we store them as `[String: JSONValue]`.
    public let modelInfo: [String: JSONValue]?
}

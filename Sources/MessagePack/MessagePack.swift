import Foundation

/// The MessagePackValue enum encapsulates one of the following types: Nil, Bool, Int, UInt, Float, Double, String, Binary, Array, Map, and Extended.
public enum MessagePackValue {
    case `nil`
    case bool(Bool)
    case int(Int64)
    case uint(UInt64)
    case float(Float)
    case double(Double)
    case string(String)
    case binary(Data)
    case array([MessagePackValue])
    case map([MessagePackValue: MessagePackValue])
    case extended(Int8, Data)
}

extension MessagePackValue: CustomStringConvertible {
    public var description: String {
        switch self {
        case .nil:
            return "nil"
        case .bool(let value):
            return "bool(\(value))"
        case .int(let value):
            return "int(\(value))"
        case .uint(let value):
            return "uint(\(value))"
        case .float(let value):
            return "float(\(value))"
        case .double(let value):
            return "double(\(value))"
        case .string(let string):
            return "string(\(string))"
        case .binary(let data):
            return "data(\(data))"
        case .array(let array):
            return "array(\(array.description))"
        case .map(let dict):
            return "map(\(dict.description))"
        case .extended(let type, let data):
            return "extended(\(type), \(data))"
        }
    }
}

extension MessagePackValue: Equatable {
    public static func ==(lhs: MessagePackValue, rhs: MessagePackValue) -> Bool {
        switch (lhs, rhs) {
        case (.nil, .nil):
            return true
        case (.bool(let lhv), .bool(let rhv)):
            return lhv == rhv
        case (.int(let lhv), .int(let rhv)):
            return lhv == rhv
        case (.uint(let lhv), .uint(let rhv)):
            return lhv == rhv
        case (.int(let lhv), .uint(let rhv)):
            return lhv >= 0 && UInt64(lhv) == rhv
        case (.uint(let lhv), .int(let rhv)):
            return rhv >= 0 && lhv == UInt64(rhv)
        case (.float(let lhv), .float(let rhv)):
            return lhv == rhv
        case (.double(let lhv), .double(let rhv)):
            return lhv == rhv
        case (.string(let lhv), .string(let rhv)):
            return lhv == rhv
        case (.binary(let lhv), .binary(let rhv)):
            return lhv == rhv
        case (.array(let lhv), .array(let rhv)):
            return lhv == rhv
        case (.map(let lhv), .map(let rhv)):
            return lhv == rhv
        case (.extended(let lht, let lhb), .extended(let rht, let rhb)):
            return lht == rht && lhb == rhb
        default:
            return false
        }
    }
}

extension MessagePackValue: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .nil: hasher.combine(0);
        case .bool(let value): hasher.combine(value);
        case .int(let value): hasher.combine(value);
        case .uint(let value): hasher.combine(value);
        case .float(let value): hasher.combine(value);
        case .double(let value): hasher.combine(value);
        case .string(let string): hasher.combine(string);
        case .binary(let data): hasher.combine(data);
        case .array(let array): hasher.combine(array);
        case .map(let dict): hasher.combine(dict);
        case .extended(let type, let data):
            hasher.combine(type);
            hasher.combine(data);
        }
    }
}

public enum MessagePackError: Error {
    case invalidArgument
    case insufficientData
    case invalidData
}

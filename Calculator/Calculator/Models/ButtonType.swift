import Foundation
import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case operation(_ operation: Operation)
    case clear
    case allClear
    case toggle
    case percent
    case equal
    case decimal
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .clear:
            return "C"
        case .allClear:
            return "AC"
        case .toggle:
            return "⁺⁄₋"
        case .percent:
            return "%"
        case .equal:
            return "="
        case .decimal:
            return "."
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .digit, .operation, .decimal, .equal:
            return .white
        case .clear, .allClear, .toggle, .percent:
            return .black
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit, .decimal:
            return .secondary
        case .operation, .equal:
            return .orange
        default:
            return Color(.lightGray)
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .operation, .equal:
            return 44
        case .digit, .decimal:
            return 40
        default:
            return 34
        }
    }
    
    var fontWeight: Font.Weight {
        switch self {
        case .digit:
            return .regular
        default:
            return .medium
        }
    }
    
    var offCenter: Bool {
        switch self {
        case .operation, .equal:
            return true
        default:
            return false
        }
    }

}

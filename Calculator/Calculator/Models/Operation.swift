import Foundation

enum Operation: CaseIterable, CustomStringConvertible {
    case plus, minus, multiply, divide
    
    var description: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "−"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        }
    }
}

import Foundation

extension CalculatorView {
    
    final class ViewModel: ObservableObject {
        
        @Published private var calculator = Calculator()
        
        var displayText: String {
            return calculator.displayText
        }
        
        var buttonTypes: [[ButtonType]] {
            let clearType: ButtonType = calculator.showAllClear ? .allClear : .clear
            return [
             [clearType, .toggle, .percent, .operation(.divide)],
             [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiply)],
             [.digit(.four), .digit(.five), .digit(.six), .operation(.minus)],
             [.digit(.one), .digit(.two), .digit(.three), .operation(.plus)],
             [.digit(.zero), .decimal, .equal]]
        }
        
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(digit)
            case .operation(let operation):
                calculator.setOperation(operation)
            case .clear:
                calculator.clear()
            case .allClear:
                calculator.allClear()
            case .toggle:
                calculator.toggle()
            case .percent:
                calculator.percent()
            case .equal:
                calculator.equal()
            case .decimal:
                calculator.decimal()
            }
        }
        
        func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
            // buttonType이 .operation이면 operation에 넣기
            guard case let .operation(operation) = buttonType else { return false }
            return calculator.operationIsHighlighted(operation)
        }
    }
}

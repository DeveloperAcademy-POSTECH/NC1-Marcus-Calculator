import Foundation

struct Calculator {
    
    private struct ArithmeticExpression: Equatable {
        var number: Decimal
        var operation: Operation
        
        func equal(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .plus:
                return number + secondNumber
            case .minus:
                return number - secondNumber
            case .multiply:
                return number * secondNumber
            case .divide:
                return number / secondNumber
            }
        }
    }
    
    private var newNumber: Decimal? {       // 새로 입력하는 숫자
        // 값이 변하면 carryingNegative 초기화
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
        }
    }
    
    
    private var expression: ArithmeticExpression?       // 계산식
    
    private var result: Decimal?        // 결과값
    
    var displayText: String {       // String으로 변환된 숫자를 콤마 넣어서 출력
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    private var number: Decimal? {      // 현재 표시중인 숫자
        if pressedClear || carryingDecimal {
            return newNumber
        } else {
            return newNumber ?? expression?.number ?? result
        }
    }
    
    // ViewModel에서 AC보여줄지 C보여줄지 알려줌
    var showAllClear: Bool {
        newNumber == nil && expression == nil && result == nil || pressedClear
    }
    
    private var pressedClear: Bool = false          // C가 눌렸는지 유무
    private var carryingNegative: Bool = false      // 마이너스 사인 유무
    private var carryingDecimal: Bool = false       // 마지막에 . 달려있는지 유무
    private var carryingZeroCount: Int = 0          // 0 개수 체크
    
    private var containsDecimal: Bool {      // 현재 표시중인 숫자의 String에 .이 있는지
        return getNumberString(forNumber: number).contains(".")
    }
    
    // newNumber를 String으로 바꿔서 새로운 숫자를 넣고 다시 변환
    mutating func setDigit(_ digit: Digit) {
        // .이 들어있고 입력값이 0이면 0 개수 늘림
        if containsDecimal	 && digit == .zero {
            carryingZeroCount += 1
        } else if canAddDigit(digit) {
            let numberString = getNumberString(forNumber: newNumber)
            newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        }
    }
    
    mutating func setOperation(_ operation: Operation) {
        // 이미 숫자가 있다면(새로운 입력 or 이전 결과값) number에 입력
        guard var number = newNumber ?? result else { return }
        
        // 이미 계산중이면(existingExpression) number를 사용해서 계산하고 결과를 number에 입력
        if let existingExpression = expression {
            number = existingExpression.equal(with: number)
        }
        // 수식 입력
        expression = ArithmeticExpression(number: number, operation: operation)
        
        // newNumber 리셋
        newNumber = nil
    }
    
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        pressedClear = true
    }
    
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
    }
    
    mutating func toggle() {
        // 0에 마이너스를 넣으려면 String을 수정해야함
        // newNumber 혹은 result가 있는지 확인 후 변환
        if let number = newNumber {
            newNumber = -number
            return
        }
        
        if let number = result {
            result = -number
            return
        }
        
        carryingNegative.toggle()
    }
    
    mutating func percent() {
        // newNumber 혹은 result가 있는지 확인 -> 100으로 나눠서 result에 저장
        if let number = newNumber {
            newNumber = number / 100
            return
        }
        
        if let number = result {
            result = number / 100
            return
        }
    }
    
    mutating func equal() {
        // newNumber와 현재 수식(expression)을 꺼냄
        guard let number = newNumber, let expressionFor = expression else { return }
        
        // 계산해서 result에 저장
        result = expressionFor.equal(with: number)
        
        // newNumber와 expression 리셋
        newNumber = nil
        expression = nil
    }
    
    mutating func decimal() {
        // 이미 . 이 있으면 무시, 없으면 . 넣음
        // 소수점 숫자에 0이 계속 추가될 수 있도록함
        if containsDecimal { return }
        carryingDecimal = true
    }
    
    
    // Decimal을 String으로 변환 (formatted로 숫자에 , 들어가도록, map으로 간단한 옵셔널 언래핑)
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        
        if carryingNegative { numberString.insert("-", at: numberString.startIndex) }
        if carryingDecimal { numberString.insert(".", at: numberString.endIndex) }
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }
    
    // 숫자 입력 가능한지 : 현재 숫자가 없거나 입력이 0이면 안됨
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
    
    // 계산이 진행중이고 새로운 숫자가 입력되지 않으면 버튼에 하이라이트
    func operationIsHighlighted(_ operation: Operation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
    
}

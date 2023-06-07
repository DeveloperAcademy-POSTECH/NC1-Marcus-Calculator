import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGFloat
    var foregroundColor: Color
    var backgroundColor: Color
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var isWide: Bool = false
    var isOffCenter: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .baselineOffset(isOffCenter ? 3 : 0)    // 연산자 센터값 미세조정
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size)
            .font(.system(size: fontSize, weight: fontWeight))
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
    
    
}

struct CalculatorButtonStyle_Previews: PreviewProvider {
    static let buttonType: ButtonType = .negative
    
    static var previews: some View {
        Button(buttonType.description) { }
            .buttonStyle(CalculatorButtonStyle(size: 80, foregroundColor: buttonType.foregroundColor, backgroundColor: buttonType.backgroundColor, fontSize: buttonType.fontSize, fontWeight: buttonType.fontWeight))
    }
}

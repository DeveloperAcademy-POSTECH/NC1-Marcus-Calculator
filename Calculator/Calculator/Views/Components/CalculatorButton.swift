import SwiftUI

extension ContentView {
    struct CalculatorButton: View {
        let buttonType: ButtonType
        
        func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.size.width
            return (screenWidth - (Constants.padding * 2) - (Constants.spacing * 3)) / 4
        }
        
//        func checkOffCenter() -> Bool {
//            if buttonType. is Operation {
//
//            }
//        }
        
        var body: some View {
            Button(buttonType.description) { }
                .buttonStyle(CalculatorButtonStyle(size: getButtonSize(),
                                                   foregroundColor: buttonType.foregroundColor,
                                                   backgroundColor: buttonType.backgroundColor,
                                                   fontSize: buttonType.fontSize,
                                                   fontWeight: buttonType.fontWeight,
                                                   isWide: buttonType == .digit(.zero),
                                                   isOffCenter: buttonType.offCenter))
        }
    }
}

import SwiftUI

extension CalculatorView {
    struct CalculatorButton: View {
        
        @EnvironmentObject private var viewModel: ViewModel
        let buttonType: ButtonType
        
        var body: some View {
            Button(buttonType.description) {
                viewModel.performAction(for: buttonType)
            }
                .buttonStyle(CalculatorButtonStyle(size: getButtonSize(),
                                                   foregroundColor: getForegroundColor(),
                                                   backgroundColor: getBackgroundColor(),
                                                   fontSize: buttonType.fontSize,
                                                   fontWeight: buttonType.fontWeight,
                                                   isWide: buttonType == .digit(.zero),
                                                   isOffCenter: buttonType.offCenter))
        }
        
        func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.size.width
            return (screenWidth - (Constants.padding * 2) - (Constants.spacing * 3)) / 4
        }
        
        // buttonTypeIsHighlighted에 따라 글씨/배경 색 반전
        private func getForegroundColor() -> Color {
            return viewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
        }
        private func getBackgroundColor() -> Color {
            return viewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
        }

    }
}

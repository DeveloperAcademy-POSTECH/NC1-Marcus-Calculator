import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Spacer()
            displayText
            buttonPad
        }
        .padding(Constants.padding)
        .background(Color.black)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}


extension CalculatorView {
    
    private var displayText: some View {
        Text(viewModel.displayText)
            .font(.system(size: 92, weight: .thin))
            .lineLimit(1)
            .minimumScaleFactor(0.2)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var buttonPad: some View {
        VStack(spacing: Constants.spacing) {
            ForEach(viewModel.buttonTypes, id:\.self) { row in
                HStack(spacing: Constants.spacing) {
                    ForEach(row, id:\.self) { buttonType in
                        CalculatorButton(buttonType: buttonType)
                    }
                }
            }
        }
    }
}

import SwiftUI

struct ContentView: View {
    
    var buttonTypes: [[ButtonType]] {
        [[.allClear, .negative, .percent, .operation(.divide)],
         [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiply)],
         [.digit(.four), .digit(.five), .digit(.six), .operation(.minus)],
         [.digit(.one), .digit(.two), .digit(.three), .operation(.plus)],
         [.digit(.zero), .decimal, .equal]]
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("0")
                .font(.system(size: 92, weight: .thin))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            // 2차원 배열의 버튼 불러내기
            VStack(spacing: Constants.spacing) {
                ForEach(buttonTypes, id:\.self) { row in
                    HStack(spacing: Constants.spacing) {
                        ForEach(row, id:\.self) { buttonType in
                            CalculatorButton(buttonType: buttonType)
                        }
                    }
                }
            }
        }
        .padding(Constants.padding)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

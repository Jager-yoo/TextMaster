import SwiftUI

struct ContentView: View {

  @State private var text: String = ""
  @FocusState private var isTextMasterFocused: Bool

  // MARK: 파라미터 조절
  private let minLine: Int = 1
  private let maxLine: Int = 5
  private let fontSize: Double = 24

  var body: some View {
    VStack(spacing: 30) {
      VStack(alignment: .leading) {
        Text("TextMaster 파라미터 값")
          .font(.title.bold())
        Text("- 최소 라인수: \(minLine)")
        Text("- 최대 라인수: \(maxLine)")
        Text("- 폰트 사이즈: \(String(format: "%.1f", fontSize))")
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(.yellow.opacity(0.2))
      )

      TextField("연결된 텍스트 필드", text: $text)
        .textFieldStyle(.roundedBorder)

      TextMaster(
        text: $text,
        isFocused: $isTextMasterFocused,
        minLine: minLine,
        maxLine: maxLine,
        fontSize: fontSize,
        becomeFirstResponder: true)

      HStack {
        Button("FOCUS IN", action: { isTextMasterFocused = true })
          .disabled(isTextMasterFocused)

        Button("FOCUS OUT", action: { isTextMasterFocused = false })
          .disabled(!isTextMasterFocused)
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

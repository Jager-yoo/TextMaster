import SwiftUI

struct ContentView: View {

  @State private var text: String = ""
  @State private var isTextMasterFocused: Bool = false

  private let minLine: Int = 1
  private let maxLine: Int = 5
  private let fontSize: Double = 24

  var body: some View {
    VStack(spacing: 30) {
      VStack(alignment: .leading) {
        Text("TextMaster 파라미터 값")
          .font(.title)
        Text("- 최소 라인수: \(minLine)")
        Text("- 최대 라인수: \(maxLine)")
        Text("- 폰트 사이즈: \(String(format: "%.1f", fontSize))")
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(.yellow.opacity(0.2))
      )

      TextField("연결된 더미", text: $text)
        .textFieldStyle(.roundedBorder)

      TextMaster(
        text: $text,
        isFocused: $isTextMasterFocused,
        minLine: minLine,
        maxLine: maxLine,
        fontSize: fontSize,
        becomeFirstResponder: true)

      Button("포커스 빼기") {
        isTextMasterFocused = false
      }
      .disabled(!isTextMasterFocused)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

import SwiftUI

struct ContentView: View {

  @State private var text: String = ""
  @State private var isTextMasterFocused: Bool = false

  var body: some View {
    VStack(spacing: 30) {
      TextField("연결된 더미", text: $text)
        .textFieldStyle(.roundedBorder)

      TextMaster(text: $text, isFocused: $isTextMasterFocused, minLine: 2, maxLine: 5, fontSize: 24)

      Button("포커스 빼기") {
        isTextMasterFocused = false
      }
      .buttonStyle(.bordered)
      .disabled(!isTextMasterFocused)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

//
//  ContentView.swift
//  TextMaster
//
//  Created by 유재호 on 2023/02/11.
//

import SwiftUI

struct ContentView: View {

  @State private var text: String = ""
  @State private var isTextMasterFocused: Bool = false

  var body: some View {
    VStack(spacing: 30) {
      TextMaster(text: $text, isFocused: $isTextMasterFocused, minLine: 1, maxLine: 5, minHeight: 40, maxHeight: 200, fontSize: 16)

      Button("포커스 빼기") {
        isTextMasterFocused = false
      }
      .buttonStyle(.bordered)
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

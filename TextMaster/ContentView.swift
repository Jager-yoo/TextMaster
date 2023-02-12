//
//  ContentView.swift
//  TextMaster
//
//  Created by 유재호 on 2023/02/11.
//

import SwiftUI

struct ContentView: View {

  @State private var text: String = ""

  var body: some View {
    VStack {
      TextMaster(text: $text, minHeight: 40, maxHeight: 200, fontSize: 16)
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

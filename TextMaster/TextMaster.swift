//
//  TextMaster.swift
//  TextMaster
//
//  Created by 유재호 on 2023/02/12.
//

import SwiftUI

struct TextMaster: View {

  @Binding var text: String
  @State private var isFocused: Bool = false
  @State private var dynamicHeight: CGFloat

  let minHeight: CGFloat
  let maxHeight: CGFloat
  let fontSize: CGFloat

  init(text: Binding<String>, minHeight: CGFloat, maxHeight: CGFloat, fontSize: CGFloat) {
    _text = text
    self.minHeight = minHeight
    self.maxHeight = maxHeight
    self.fontSize = fontSize
    _dynamicHeight = State(initialValue: minHeight)
  }

  var body: some View {
    VStack {
      UITextViewRepresentable(
        text: $text,
        isFocused: $isFocused,
        dynamicHeight: $dynamicHeight,
        minHeight: minHeight,
        maxHeight: maxHeight,
        fontSize: fontSize)
        .frame(height: dynamicHeight)
    }
    .border(isFocused ? Color.blue : Color.gray, width: 1)
  }
}

struct UITextViewRepresentable: UIViewRepresentable {

  @Binding var text: String
  @Binding var isFocused: Bool
  @Binding var dynamicHeight: CGFloat

  let minHeight: CGFloat
  let maxHeight: CGFloat
  let fontSize: CGFloat

  func makeUIView(context: UIViewRepresentableContext<UITextViewRepresentable>) -> UITextView {
    let textView = UITextView(frame: .zero)
    textView.delegate = context.coordinator
    textView.font = .systemFont(ofSize: fontSize)
    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textView.textContainer.lineFragmentPadding = .zero
    textView.textContainerInset = .zero
    return textView
  }

  func makeCoordinator() -> UITextViewRepresentable.Coordinator {
    Coordinator(
      text: $text,
      isFocused: $isFocused,
      dynamicHeight: $dynamicHeight,
      minHeight: minHeight,
      maxHeight: maxHeight)
  }

  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewRepresentable>) {
    uiView.text = self.text
  }

  final class Coordinator: NSObject, UITextViewDelegate {

    @Binding var text: String
    @Binding var isFocused: Bool
    @Binding var dynamicHeight: CGFloat

    let minHeight: CGFloat
    let maxHeight: CGFloat

//    private let lineHeight: CGFloat

    init(
      text: Binding<String>,
      isFocused: Binding<Bool>,
      dynamicHeight: Binding<CGFloat>,
      minHeight: CGFloat,
      maxHeight: CGFloat)
    {
      _text = text
      _isFocused = isFocused
      _dynamicHeight = dynamicHeight
      self.minHeight = minHeight
      self.maxHeight = maxHeight
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
      self.text = textView.text ?? ""
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
      self.isFocused = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      self.isFocused = false
    }

    func textViewDidChange(_ textView: UITextView) {
      guard let spacing = textView.font?.lineHeight else { return }

      guard !text.isEmpty else {
        dynamicHeight = minHeight
        return
      }

      let newSize = textView.sizeThatFits(.init(width: textView.frame.width, height: .greatestFiniteMagnitude))

      guard newSize.height > minHeight, newSize.height < maxHeight else {
        print("사이즈 잴 때 리턴당함 -> \(textView.text!)")
        return
      }

      DispatchQueue.main.async { [weak self] in // call in next render cycle
        self?.dynamicHeight = newSize.height
      }

//      guard let spacing = textView.font?.lineHeight else {
//        print("리턴당함")
//        return
//      }
//
//      if textView.contentSize.height > dynamicHeight, dynamicHeight <= maxHeight - spacing {
//        dynamicHeight += spacing
//        print("🥕 spacing: \(spacing)", "dynamic: \(dynamicHeight)")
//      } else if text.isEmpty {
//        dynamicHeight = minHeight
//      }
    }
  }
}

struct TextMaster_Previews: PreviewProvider {
  static var previews: some View {
    TextMaster(text: .constant("안녕하세요!"), minHeight: 40, maxHeight: 200, fontSize: 16)
  }
}

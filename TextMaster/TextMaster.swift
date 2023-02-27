//
//  TextMaster.swift
//  TextMaster
//
//  Created by 유재호 on 2023/02/12.
//

import SwiftUI

struct TextMaster: View {

  @Binding var text: String
  @Binding var isFocused: Bool
  @State private var dynamicHeight: CGFloat

  let minLine: Int
  let maxLine: Int
  let minHeight: CGFloat
  let maxHeight: CGFloat
  let font: UIFont

  init(text: Binding<String>, isFocused: Binding<Bool>, minLine: Int, maxLine: Int, minHeight: CGFloat, maxHeight: CGFloat, fontSize: CGFloat) {
    _text = text
    _isFocused = isFocused
    self.minLine = minLine
    self.maxLine = maxLine
    self.minHeight = minHeight
    self.maxHeight = maxHeight

    let font = UIFont.systemFont(ofSize: fontSize)
    self.font = font
    _dynamicHeight = State(initialValue: font.lineHeight * CGFloat(minLine))
  }

  var body: some View {
    VStack {
      UITextViewRepresentable(
        text: $text,
        isFocused: $isFocused,
        dynamicHeight: $dynamicHeight,
        minLine: minLine,
        maxLine: maxLine,
        minHeight: minHeight,
        maxHeight: maxHeight,
        font: font)
        .frame(height: dynamicHeight)
    }
    .border(isFocused ? Color.blue : Color.gray, width: 1)
  }
}

struct UITextViewRepresentable: UIViewRepresentable {

  @Binding var text: String
  @Binding var isFocused: Bool
  @Binding var dynamicHeight: CGFloat

  let minLine: Int
  let maxLine: Int
  let minHeight: CGFloat
  let maxHeight: CGFloat
  let font: UIFont

  func makeUIView(context: UIViewRepresentableContext<UITextViewRepresentable>) -> UITextView {
    let textView = UITextView(frame: .zero)
    textView.delegate = context.coordinator
    textView.font = font
    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textView.textContainer.lineFragmentPadding = .zero
    textView.textContainerInset = .zero
    textView.isScrollEnabled = false
    return textView
  }

  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewRepresentable>) {
    uiView.text = self.text
  }

  func makeCoordinator() -> UITextViewRepresentable.Coordinator {
    Coordinator(
      text: $text,
      isFocused: $isFocused,
      dynamicHeight: $dynamicHeight,
      minHeight: font.lineHeight * CGFloat(minLine),
      maxHeight: font.lineHeight * CGFloat(maxLine),
      fontLineHeight: font.lineHeight)
  }

  final class Coordinator: NSObject, UITextViewDelegate {

    @Binding var text: String
    @Binding var isFocused: Bool
    @Binding var dynamicHeight: CGFloat

    let minHeight: CGFloat
    let maxHeight: CGFloat
    let fontLineHeight: CGFloat

    init(
      text: Binding<String>,
      isFocused: Binding<Bool>,
      dynamicHeight: Binding<CGFloat>,
      minHeight: CGFloat,
      maxHeight: CGFloat,
      fontLineHeight: CGFloat)
    {
      _text = text
      _isFocused = isFocused
      _dynamicHeight = dynamicHeight
      self.minHeight = minHeight
      self.maxHeight = maxHeight
      self.fontLineHeight = fontLineHeight
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
      self.isFocused = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      self.isFocused = false
    }

    func textViewDidChange(_ textView: UITextView) {
      self.text = textView.text ?? ""

      guard !text.isEmpty else {
        dynamicHeight = minHeight
        return
      }

      let newSize = textView.sizeThatFits(.init(width: textView.frame.width, height: .greatestFiniteMagnitude))

      guard newSize.height > minHeight, newSize.height < maxHeight else {
        if newSize.height > maxHeight {
          textView.isScrollEnabled = true
          textView.flashScrollIndicators()
        } else {
          textView.isScrollEnabled = false
        }
        return
      }

      DispatchQueue.main.async { [weak self] in // call in next render cycle
        self?.dynamicHeight = newSize.height
      }
    }
  }
}

struct TextMaster_Previews: PreviewProvider {
  static var previews: some View {
    TextMaster(text: .constant("안녕하세요!"), isFocused: .constant(true), minLine: 1, maxLine: 5, minHeight: 40, maxHeight: 200, fontSize: 16)
  }
}

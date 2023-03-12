# TextMaster
### 🗜Enhanced SwiftUI's TextEditor API powered by UITextView

<br>

## ✨ 설명

`SwiftUI` 에서 여러 줄의 텍스트 입력을 받기 위해선 무엇을 사용해야 할까요?

iOS 14.0+ 부터 제공되는 [TextEditor](https://developer.apple.com/documentation/swiftui/texteditor)가 있지만, 기능이 제한적입니다.

스크롤 기능을 켜고 끄거나, firstResponder 설정, 다이나믹 height 조절, 백그라운드 컬러 변경 등이 불가능합니다.
즉, TextEditor 로는 실무에서 필요한 복잡한 요구사항을 충족시키기 어렵습니다.

`TextMaster` 는 UIKit 에서 iOS 2.0+ 부터 제공되는 근본 API 인 [UITextView](https://developer.apple.com/documentation/uikit/uitextview)의 기능을
`SwiftUI` 에서 사용할 수 있도록 wrapping 한 구조체입니다.

`TextMaster` 는 `iOS 15.0+` 부터 사용 가능합니다.

<br>

일부러 SPM 라이브러리로 만들지 않았습니다.

본 레포의 [TextMaster.swift](https://github.com/Jager-yoo/TextMaster/blob/main/TextMaster/TextMaster.swift) 파일 내부를 복사해서 가져가면, 바로 사용이 가능합니다.

커스텀이 필요한 부분은 스스로 수정해서 사용하셔도 됩니다. 😄

<br>

## ✨ 특징

실무에서 기획자/디자이너와 화면에 올리는 TextView 의 스펙을 이야기하다 보면, 단순히 고정 height 로 결정될 때도 있지만

간혹, 이런 스펙을 전달 받는 경우도 있습니다.

> "처음엔 1줄만 표시되다가, 최대 5줄까지 늘어나고, 그 보다 많아지면 스크롤이 가능하도록 만들어주세요."

> "아 근데 폰트는 24 정도로 좀 크게 해주시고요."

> "처음에 이 페이지로 진입할 때, 바로 TextView 에 포커스가 들어오면서 키보드가 올라오게 해주세요."

충분히 합리적인 스펙이지만, 이 스펙을 SwiftUI 에서 구현하는 건 매우~ 까다롭습니다.

하지만 `TextMaster` 로는 쉽게 구현 가능합니다.

```swift
TextMaster(
  text: $text, // @State 텍스트와 바인딩
  isFocused: $isTextMasterFocused, // @FocusState 와 바인딩
  minLine: 1, // 최소 1줄 (디폴트)
  maxLine: 5, // 최대 5줄 (그 이후로 늘어나면 스크롤 기능이 작동)
  fontSize: 24, // 폰트 사이즈 (Double 타입)
  becomeFirstResponder: true) // true 가 들어가면, 이 페이지가 나타날 때 자동으로 포커스가 잡히며 키보드 올라옴
```

![TextMaster](https://user-images.githubusercontent.com/71127966/224528495-e6f99b75-f936-412b-be7c-2071c2d0d1d0.gif)

<br>

스펙이 이렇게 들어온다고 가정해보죠.

> "최소 2줄에서 시작, 최대 4줄 까지만 커지다가 스크롤 작동, 폰트 사이즈는 16 으로 부탁드려요."

> "아, 백그라운드는 quaternary 로 부탁드려요."

```swift
TextMaster(
  text: $text,
  isFocused: $isTextMasterFocused,
  minLine: 2,
  maxLine: 5,
  fontSize: 16)
  .background(.tertiary)
```

![TextMaster2](https://user-images.githubusercontent.com/71127966/224528938-983cea8b-83a7-4260-a342-21d35790806a.gif)


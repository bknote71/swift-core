import Foundation

// MARK: 서브스트링
// - 문자열의 일부를 나타낸다.
// - 메모리 효율을 위해 원래 문자열의 메모리를 참조(공유)한다. (public var base: String { get })
// - 서브스트링을 오래 유지하면 원래 문자열의 메모리도 해제되지 않기 때문에 메모리 관리에 주의해야 한다. (strong reference)
// - 필요에 따라 이를 String으로 변환하여 사용해야 할 수 있다.

// MARK: 문자열
// - 문자열은 독립적인 문자 시퀀스(Sequence)를 나타낸다.
// - 값을 '복사'하여 저장하므로 메모리를 따로 차지한다.
// - 메모리 관리 단순하며 서브스트링보다 광범위한 기능을 제고앟낟.

let str = "hello, swift!"
let startIndex = str.index(str.startIndex, offsetBy: 7)
let endIndex = str.index(str.endIndex, offsetBy: -1)

// Range로 Substring 생성
let substring = str[startIndex..<endIndex]

print("\(startIndex)~\(endIndex): \(substring)")
print("substring base \(substring.base)")
let stringFromSubstring = String(substring)



// MARK: 문자열 보간법
// - 문자열 안에 변수나 상수의 값을 삽입하는 방법
// - \(변수) 형태로 삽입

// 주의
// - 문자열 보간법을 사용하면 코드가 간결해지지만, 너무 많이 사용하면 가독성이 떨어질 수 있다.
// - 특히 복잡한 표현식을 보간할 때는 주의해야 한다.
// - 간단한 표현식(예. 변수명) 정도로 사용하는 것이 좋다고 한다.
// - 복잡한 로직의 경우 변수에 대입하고 변수를 사용하는 방법을 추천한다고 함.

let name = "Swift"
let version = 5.0
let message = "Welcome to \(name) \(version)"
print(message)

// 서브스트링을 문자열 보간법을 통해 새로운 문자열에 포함\

let numberString = "12345"
let sIndex = numberString.index(numberString.startIndex, offsetBy: 1)
let eIndex = numberString.index(numberString.endIndex, offsetBy: -1)
let subnumber = numberString[sIndex..<eIndex] // "234"

// 서브스트링을 문자열 보간법으로 초기화
let interpolatedString = "The extracted number is: \(subnumber)"
print(interpolatedString) // 출력: "The extracted number is: 234"

// MARK: 정규식(NSRegularExpression)
// - 문자열 검색(및 추출), 치환 등의 작업을 활 수 있다.

// 1. 검색 및 추출
let text = "My phone number is 123-456-7890, 999-999-9999."
let pattern = "\\d{3}-\\d{3}-\\d{4}" // 전화번호 패턴
do {
  let regex = try NSRegularExpression(pattern: pattern)
  let mathces = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
  
  for match in mathces {
    if let range = Range(match.range, in: text) {
      print("Found match: \(text[range])")
    }
  }
} catch {
  print("Invalid regex")
}

// 2. 치환
let replacement = "XXX-XXX-XXX"
do {
  let regex = try NSRegularExpression(pattern: pattern)
  let newText = regex.stringByReplacingMatches(in: text,
                                               range: NSRange(text.startIndex..., in: text),
                                               withTemplate: replacement)
  print("new text: \(newText)")
} catch {
  print("Invalid regex")
}

// MARK: Range
// - Range와 NSRange는 모두 범위를 나타내기 위한 구조체이다.
// - Range는 Swift 표준 라이브러리의 일부이고, NSRange는 Foundation 프레임워크의 일부로, objc와의 상호 운용성을 위해 사용

// 1. Range와 ClosedRange
// - Range: 시작과 끝 값을 가지며, 끝 값을 포함하지 않는 범위를 나타낸다.
// - ClosedRange: 시작과 끝 값을 가지며, 끝 값을 포함하는 범위를 나타낸다.
let openRange: Range<Int> = 0..<5
let closedRange: ClosedRange<Int> = 0...5
let partialRange = 0... // PartialRangeFrom
print(openRange) // 0..<5
print(closedRange) // 0...5
print(partialRange)

// 2. NSRange
// - objc와의 상호 운용성을 위해 사용
// - 문자열 조작, 정규식(NSRegularExpression) 등에서 자주 사용
// - '시작 인덱스와 길이'를 기반으로 범위 탐색
let nsRange = NSRange(location: 0, length: 5)
print(nsRange) // {0, 5}

// Rnage와 NSRange 간의 변환
// - 문자열에서 NSRange를 사용하려면 변환이 필요할 때가 많다.

let swiftString = "Hello, Swift"
if let range = swiftString.range(of: "Swift") {
  print("Found range: \(range)")
  
  // Range to NSRange
  let nsRange1 = NSRange(range, in: swiftString)
  let nsRange2 = NSRange(swiftString.startIndex..., in: swiftString)
  
  print("Converted to NSRange1: \(nsRange1)")
  print("Converted to NSRange2: \(nsRange2)")
  
  // NSRange to Range
  let convertedRange1 = Range(nsRange1, in: swiftString)
  let convertedRange2 = Range(nsRange2, in: swiftString)
  
  print("Converted back to Range1: \(convertedRange1!)")
  print("Converted back to Range2: \(convertedRange2!)")
  
  print("Substring1: \(swiftString[convertedRange1!])")
  print("Substring2: \(swiftString[convertedRange2!])")
  
  // 5 떨어진 곳에서 시작
  let nsRange3 = NSRange(swiftString.index(swiftString.startIndex, offsetBy: 7)..., in: swiftString)
  print("substring: \(swiftString[Range(nsRange3, in: swiftString)!])")
}

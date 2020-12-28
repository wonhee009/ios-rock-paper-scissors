# 묵찌빠

## 🐱GitHub

- 20/11/06 code

[wonhee009/ios-rock-paper-scissors](https://github.com/wonhee009/ios-rock-paper-scissors/blob/1-lasagna/RockPaperScissors/RockPaperScissors/main.swift)

- 20/12/28 develop code

[wonhee009/ios-rock-paper-scissors](https://github.com/wonhee009/ios-rock-paper-scissors/tree/develop-project)

## 🛠 Stack

- Swift

## 🖋 Review

```swift
let order = "가위(1), 바위(2), 보(3)! <종료: 0> : "
let orderRPS = "묵(1), 찌(2), 빠(3)! <종료: 0> : "
```

### Q. 반복적으로 사용할 코드를 상수로 선언한 것이 정말 좋아요! 스위프트에서 연관된 상수끼리 묶어주는 방법은 없을까요? :)

```swift
// 1차
let gameStartString: [String : String] = [
    "SRP" : "가위(1), 바위(2), 보(3)! <종료: 0> : ",
    "RSP" : "묵(1), 찌(2), 빠(3)! <종료: 0> : "
]
```

`Dictionary`로 String을 묶어 주었다.

```swift
// 2차 
private enum gameStartMessage {
	static let scissorRockPaper = "가위(1), 바위(2), 보(3)! <종료: 0> : "
	static let rockScissorPaper = "묵(1), 찌(2), 빠(3)! <종료: 0> : "
}
```

`enum`을 통해 연관된 String끼리 묶어줄 수 있고, `Type Property`를 통해 `Stored Property`처럼 사용할 수 있다.

---

```swift
/*
 * step 1: 1(가위), 2(바위), 3(보)
 * step 2: 1(바위), 2(가위), 3(보)
 */
// 컴퓨터의 손 상태
var computerHand: Int
// 사용자의 손 상태
var userHand: Int

 // 묵찌빠 턴 (1: 사용자, -1: 컴퓨터, 0: 불가)
var gameTurn = 0

 /*
 * 가위바위보 (step1) 게임 함수
 * return 0 -> 비김
 * return 1 -> 사용자 이김
 * return -1 -> 컴퓨터 이김
 */
```

### Q. 이 주석이 없더라도 코드 해석이 가능하도록 구현하는 방법에 대해 고민해보면 좋을것 같습니다.

```swift
// 1차
enum HandState {
    case rock, scissor, paper
}

func SRPNumberToHand(_ number: Int) -> HandState? {
    switch number {
    case 1:
        return .scissor
    case 2:
        return .rock
    case 3:
        return .paper
    default:
        return nil
    }
}

func RSPNumberToHand(_ number: Int) -> HandState? {
    switch number {
    case 1:
        return .rock
    case 2:
        return .paper
    case 3:
        return .scissor
    default:
        return nil
    }
}
```

enum으로 `HandState`를 선언

`-NumberToHadn(_:)`로 입력 받은 숫자를 `HandState`로 변경

```swift
// 2차

// HandState.swift
enum HandState {
    case rock, scissor, paper
}

// ScissorRockPaper.swift
class ScissorRockPaper {
	func numberToHand(_ number: Int) -> HandState? {
        switch number {
        case 1:
            return .scissor
        case 2:
            return .rock
        case 3:
            return .paper
        default:
            return nil
        }
    }
}

// RockScissorPaper.swift
class RockScissorPaper {
	func numberToHand(_ number: Int) -> HandState? {
        switch number {
        case 1:
            return .rock
        case 2:
            return .paper
        case 3:
            return .scissor
        default:
            return nil
        }
    }
}
```

`HandState` `enum`을 하나의 file로 분리했다.

입력 받은 숫자는 어떤 게임인지에 따라 `HandState`가 다르게 반환되어야 하므로 게임에 관련한 기능들이 하나의 `class`로 묶여야 한다고 생각해 게임별로 `class`를 나눠줬다.

게임별로 해당 `class`가 기능을 하도록 `numberToHand(_:)`를 class별로 분리했다.

---

```swift
if computer == 2 {
            result =  -1
        }
        else {
            result = 1
        }
```

### Q. 1년 뒤, 내가 이 숫자를 보고 게임 결과를 유추할 수 있을까요?

```swift
// 1차
enum GameStatus: String {
    case user = "사용자"
    case computer = "컴퓨터"
    case draw
}
```

`GameStatus` `enum`으로 알아보기 힘든 숫자가 아니라 직관적으로 알 수 있도록 설정

```swift
// 2차
enum TurnStatus {
    case user
    case computer
    case draw
    
    var getWinMessage: String {
        switch self {
        case .user:
            return "사용자의 승리!"
        case .computer:
            return "컴퓨터의 승리!"
        case .draw:
            return "비겼습니다!"
        }
    }
}
```

해당 게임 턴에서의 결과를 나타내는 `enum`이므로 직관적인 네이밍에 근거해 `TurnStatus`로 이름 변경

게임 턴에 따라 사용하는 message가 있어 `read-only computed property`로 message 처리

---

```swift
guard let input = readLine() else {
        exit = true
        break
    }
```

### Q. 사용자의 입장에선 입력에 실수를 할 수 있는데, 아무런 안내 없이 갑자기 프로그램이 종료되어 버리면 당혹스러울 것 같아요.

```swift
// 1차
private let exitCode = 0
let exitMessage = "게임을 종료합니다."

if number == exitCode {
	print(exitMessage)
	return nil
}
```

종료코드를 전역적으로 설정하고 종료 메시지를 프린트한 후 종료되도록 변경

---

## ⚙️ 추가 개선점

```swift
// 1차
enum ErrorMessage : String {
    case system = "시스템 에러로 인해 다시 시도해주세요."
    case input = "잘못된 입력입니다. 다시 시도해주세요."
}
```

```swift
// 2차
enum GameError {
    case system
    case input
    
    var message: String {
        switch self {
        case .system:
            return "시스템 에러로 인해 다시 시도해주세요."
        case .input:
            return "잘못된 입력입니다. 다시 시도해주세요."
        }
    }
}
```

명시적으로 error `enum` 이름을 바꿨다.

`raw value`로 error message를 가져오는게 아니라 `computed property`로 message를 가져오도록 했다.

---

```swift
// 1차
struct GamersStatus {
    var computerHand: HandState?
    var userHand: HandState?
    var gameTurn: GameStatus?
    
    init(computerHand: HandState?, userHand: HandState?, gameTurn: GameStatus?) {
        self.computerHand = computerHand
        self.userHand = userHand
        self.gameTurn = gameTurn
    }
}
```

```swift
// 2차
struct GameStatus {
    var computerHand: HandState?
    var userHand: HandState?
    var gameTurn: TurnStatus?
}
```

해당 struct는 현재 게임의 상태를 나타내므로 명시적인 이름으로 변경했다.

struct는 init을 따로 설정해주지 않아도 되므로 삭제했다.

---

```swift
// 1차

func turnMessage(currentGameTurn: GameStatus) -> String? {
    switch currentGameTurn {
    case .computer:
        return "[컴퓨터 턴] "
    case .user:
        return "[사용자 턴] "
    default:
        return nil
    }
}

func winMessage(currentGameTurn: GameStatus) -> String? {
    switch currentGameTurn {
    case .computer:
        return "컴퓨터의 승리!"
    case .user:
        return "사용자의 승리!"
    default:
        return nil
    }
}

func nextTurnMessage(nextTurn: GameStatus) -> String? {
    switch nextTurn {
    case .computer:
        return "컴퓨터의 턴입니다"
    case .user:
        return "사용자의 턴입니다"
    default:
        return nil
    }
}
```

```swift
// 2차
enum TurnStatus {
    case user
    case computer
    case draw
    
    var getWinMessage: String {
        switch self {
        case .user:
            return "사용자의 승리!"
        case .computer:
            return "컴퓨터의 승리!"
        case .draw:
            return "비겼습니다!"
        }
    }
    
    var getTurnPrefix: String? {
        switch self {
        case .user:
            return "[사용자 턴] "
        case .computer:
            return "[컴퓨터 턴] "
        case .draw:
            return nil
        }
    }
    
    var getTurnMessage: String? {
        switch self {
        case .user:
            return "사용자의 턴입니다"
        case .computer:
            return "컴퓨터의 턴입니다"
        case .draw:
            return nil
        }
    }
}
```

게임 턴상태를 가지고 있는 `enum`에서 `read-only computed property`로 message들을 return하도록 변경했다. 

---

- `CommonGame` class를 두어 '가위바위보'와 '묵찌빠'에서 공통으로 쓰이는 (누가 이겼는지 판단하는 func) 기능을 구현하고 '가위바위보'와 '묵찌빠'에서 상속 받도록 변경
- '가위바위보'와 '묵찌빠'에 동일한 기능이지만 내부 동작은 다른 부분은 프로토콜로 묶었다.

## 💡 깨달은 점

첫번째 프로젝트 이후 약 두 달뒤 다시 적어본 코드이다.
생각보다 많은 부분이 뜯어져 나갔다.
그래도 두달동안 성장했다로 생각하고 싶다.





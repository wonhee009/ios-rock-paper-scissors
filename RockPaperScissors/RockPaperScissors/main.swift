//
//  RockPaperScissors - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

private enum GameStartMessage {
    static let scissorRockPaper = "가위(1), 바위(2), 보(3)! <종료: 0> : "
    static let rockScissorPaper = "묵(1), 찌(2), 빠(3)! <종료: 0> : "
}
private enum GameStatusMessage {
    static let win = "이겼습니다!"
    static let loose = "졌습니다!"
}

private let exitCode = 0
private let exitMessage = "게임을 종료합니다."

private var gameMode: GameMode = .scissorRockPaper
private var currentGame: GameStatus? = nil
private var isExit = false

private func initGame() -> GameStatus {
    gameMode = .scissorRockPaper
    return GameStatus(computerHand: nil, userHand: nil, gameTurn: nil)
}

private func playScissorRockPaper() {
    print(GameStartMessage.scissorRockPaper)
    
    guard let input = readLine(),
          let number = Int(input),
          number >= 0 && number <= 3 else {
        print(GameError.input.message)
        return
    }
    if number == exitCode {
        isExit = true
        print(exitMessage)
        return
    }
    
    guard let nextStatus = ScissorRockPaper.shared.game(userHandNumber: number, computerHandNumber: Int.random(in: 1...3)),
          let gameTurn = nextStatus.gameTurn else {
        return
    }
    if gameTurn == .draw {
        print(gameTurn.getWinMessage)
        return
    }
    
    currentGame = nextStatus
    gameMode = .rockScissorPaper
    
    if gameTurn == .user {
        print(GameStatusMessage.win)
    }
    else {
        print(GameStatusMessage.loose)
    }
}

private func playRockScissorPaper() {
    guard let currentTurn = currentGame?.gameTurn,
          let currentTurnPrefix = currentTurn.getTurnPrefix
    else {
        print(GameError.system.message)
        return
    }
    print(currentTurnPrefix + GameStartMessage.rockScissorPaper)
    
    guard let input = readLine(),
          let number = Int(input),
          number >= 0 && number <= 3 else {
        print(GameError.input.message)
        currentGame?.gameTurn = .computer
        return
    }
    if number == exitCode {
        isExit = true
        print(exitMessage)
        return
    }
    
    guard let nextStatus = RockScissorPaper.shared.game(userHandNumber: number, computerHandNumber: Int.random(in: 1...3)),
          let gameTurn = nextStatus.gameTurn else {
        return
    }
    if gameTurn == .draw {
        print(currentTurn.getWinMessage)
        isExit = true
        return
    }
    
    currentGame = nextStatus
    print(gameTurn.getTurnMessage)
}

private func startGame() {
    currentGame = initGame()
    while(!isExit) {
        switch gameMode {
        case .scissorRockPaper:
            playScissorRockPaper()
        case .rockScissorPaper:
            playRockScissorPaper()
        }
    }
}

startGame()

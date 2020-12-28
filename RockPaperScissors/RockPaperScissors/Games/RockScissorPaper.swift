//
//  RockScissorPaper.swift
//  RockPaperScissors
//
//  Created by Wonhee on 2020/12/28.
//

import Foundation

class RockScissorPaper: CommonGame {
    
    static let shared = RockScissorPaper()
    private override init() {}
    
    func game(userHandNumber: Int, computerHandNumber: Int) -> GameStatus? {
        guard let userHand = numberToHand(userHandNumber),
              let computerHand = numberToHand(computerHandNumber) else {
            print(GameError.system.message)
            return nil
        }

        let nextTurn = judgeGame(user: userHand, computer: computerHand)
        return GameStatus(computerHand: computerHand, userHand: userHand, gameTurn: nextTurn)
    }
    
    func numberToHand(_ number: Int) -> HandState? {
        switch number {
        case 1:
            return .rock
        case 2:
            return .scissor
        case 3:
            return .paper
        default:
            return nil
        }
    }
}

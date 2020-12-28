//
//  CommonGame.swift
//  RockPaperScissors
//
//  Created by Wonhee on 2020/12/28.
//

import Foundation

class CommonGame {
    func judgeGame(user: HandState, computer: HandState) -> TurnStatus {
        if user == computer {
            return .draw
        }
        
        switch user {
        case .rock:
            if computer == .paper {
                return .computer
            }
            return .user
        case .scissor:
            if computer == .rock {
                return .computer
            }
            return .user
        case .paper:
            if computer == .scissor {
                return .computer
            }
            return .user
        }
    }
}

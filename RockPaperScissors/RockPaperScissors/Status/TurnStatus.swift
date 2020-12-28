//
//  TurnStatus.swift
//  RockPaperScissors
//
//  Created by Wonhee on 2020/12/28.
//

import Foundation

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

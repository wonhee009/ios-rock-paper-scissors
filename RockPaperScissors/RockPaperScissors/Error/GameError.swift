//
//  GameError.swift
//  RockPaperScissors
//
//  Created by Wonhee on 2020/12/28.
//

import Foundation

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

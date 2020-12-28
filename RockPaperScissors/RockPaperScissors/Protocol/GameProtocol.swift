//
//  GameProtocol.swift
//  RockPaperScissors
//
//  Created by Wonhee on 2020/12/28.
//

import Foundation

protocol Game {
    func numberToHand(_ number: Int) -> HandState?
    func game(userHandNumber: Int, computerHandNumber: Int) -> GameStatus?
}

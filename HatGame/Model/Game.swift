//
//  Game.swift
//  HatGame
//
//  Created by Stoyan Hristov on 3.01.26.
//

import Foundation

@Observable
class Game {
    let allTeams: [Team]
    var currentTurnSkipCount: Int
    let maxiumumAllowedCardSkips: Int = 3
    let allowedTimePerTurn: Int = 60 // seconds
    var leftTimePerTurn: Int
    var difficulty: Words.Level
    let words = Words()
    private(set) var currentTeamIndex = 0
    
    var getCurrentTeam: Team {
        precondition(!allTeams.isEmpty, "No teams available")
        return allTeams[currentTeamIndex]
    }
    var previewNextTeam: Team {
        precondition(!allTeams.isEmpty, "No teams available")
        return allTeams[(currentTeamIndex + 1) % allTeams.count]
    }
    var isLastTeam: Bool { !allTeams.isEmpty && currentTeamIndex == allTeams.count - 1 }
    
    init(allTeams: [Team], currentTurnSkipCount: Int = 3, leftTimePerTurn: Int, difficulty: Words.Level, currentTeamIndex: Int = 0) {
        self.allTeams = allTeams
        self.currentTurnSkipCount = currentTurnSkipCount
        self.leftTimePerTurn = leftTimePerTurn
        self.difficulty = difficulty
        self.currentTeamIndex = currentTeamIndex
    }
    
    func getTeamsScores() -> [(teamName: String, score: Int)] {
        let sortedTeams = allTeams.sorted(by: { $0.score > $1.score })
        var scores: [(teamName: String, score: Int)] = []
        for team in sortedTeams {
            scores.append((team.name, team.score))
        }
        
        return scores
    }
    
     func getNextTeam() -> Team {
        precondition(!allTeams.isEmpty, "No teams available")
        currentTeamIndex += 1
        if currentTeamIndex == allTeams.count {
            currentTeamIndex = 0
        }
        return allTeams[currentTeamIndex]
    }
}


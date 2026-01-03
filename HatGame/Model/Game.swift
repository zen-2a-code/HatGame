//
//  Game.swift
//  HatGame
//
//  Created by Stoyan Hristov on 3.01.26.
//

struct Game {
    let teams: [Team]
    var currentTurnSkipCount: Int
    let maxiumumAllowedCardSkips: Int = 3
    let allowedTimePerTurn: Int = 60 // seconds
    var leftTimePerTurn: Int
    var difficulty: Words.Level
    var words = Words()
    
    func getTeamsScores() -> [(teamName: String, score: Int)] {
        let sortedTeams = teams.sorted(by: { $0.score > $1.score })
        var scores: [(teamName: String, score: Int)] = []
        for team in sortedTeams {
            scores.append((team.name, team.score))
        }
        
        return scores
    }
}

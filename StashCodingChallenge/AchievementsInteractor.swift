//
//  AchievementsInteractor.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import Foundation

/// Handles fetching and sending Achievements to the Presenter
class AchievementsInteractor: AchievementsInteractorProtocol {
    
    weak var presenter: AchievementsInteractorToPresenterProtocol?
    
    func fetchAchievements() {
        if let path = Bundle.main.path(forResource: "achievements", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Dictionary<String, AnyObject>
                if let achievements: AchievementEntities = try? JSONDecoder().decode(AchievementEntities.self, from: JSONSerialization.data(withJSONObject: jsonResult?["achievements"] as Any)) {
                        presenter?.achievementsFetched(achievements: achievements)
                    } else {
                        presenter?.achievementsFetchFailed(error: "Could not read AchievementEntity types from json")
                    }
            } catch {
                presenter?.achievementsFetchFailed(error: error.localizedDescription)
            }
        }
    }
}

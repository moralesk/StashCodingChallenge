//
//  AchievementsPresenter.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import Foundation

/// Manages the interactor/view relationship for a list of Achievements
class AchievementsPresenter: AchievementsPresenterProtocol {
    weak var view: AchievementsViewProtocol?
    var interactor: AchievementsInteractorProtocol?
    
    func viewDidLoad() {
        interactor?.fetchAchievements()
    }
}

// Functionality received from Interactor, passed to View
extension AchievementsPresenter: AchievementsInteractorToPresenterProtocol {
    
    func achievementsFetched(achievements: AchievementEntities) {
        view?.displayAchievements(achievements: achievements)
    }
    
    func achievementsFetchFailed(error: String) {
        view?.displayError(error)
    }
    
}

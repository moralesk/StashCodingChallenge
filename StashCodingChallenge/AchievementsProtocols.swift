//
//  AchievementsProtocols.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import UIKit

/// VIEW -> PRESENTER
protocol AchievementsPresenterProtocol: class {
    var view: AchievementsViewProtocol? { get set }
    var interactor: AchievementsInteractorProtocol? { get set }
    func viewDidLoad()
}

/// PRESENTER -> VIEW
protocol AchievementsViewProtocol: class {
    var presenter: AchievementsPresenterProtocol? { get set }
    func displayAchievements(achievements: AchievementEntities)
    func displayError(_ error: String)
}

/// PRESENTER -> INTERACTOR
protocol AchievementsInteractorProtocol: class {
    var presenter: AchievementsInteractorToPresenterProtocol? { get set }
    func fetchAchievements()
}

/// INTERACTOR -> PRESENTER
protocol AchievementsInteractorToPresenterProtocol: class {
    func achievementsFetched(achievements: AchievementEntities)
    func achievementsFetchFailed(error: String)
}

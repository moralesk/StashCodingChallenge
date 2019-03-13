//
//  AchievementsRouter.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import UIKit

/**
 Handles navigation for the Achievements flow, as well as sets the relationships between the View, Presenter, and Interactor for Achievements
 */
class AchievementsRouter {
    
    class func createAchievementsModule() -> UIViewController {
        let view = AchievementsViewController()
        let presenter: AchievementsPresenterProtocol & AchievementsInteractorToPresenterProtocol = AchievementsPresenter()
        let interactor: AchievementsInteractorProtocol = AchievementsInteractor()
        
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}

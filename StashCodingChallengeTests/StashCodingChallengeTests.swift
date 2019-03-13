//
//  StashCodingChallengeTests.swift
//  StashCodingChallengeTests
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import XCTest
@testable import StashCodingChallenge

class StashCodingChallengeTests: XCTestCase {

    var interactor: AchievementsInteractor?
    var presenter: TestAchievementsPresenter?
    
    override func setUp() {
        interactor = AchievementsInteractor()
        presenter = TestAchievementsPresenter()
        interactor?.presenter = presenter
    }

    override func tearDown() {
        interactor = nil
        presenter = nil
    }

    func testAchievementRetrieval() {
        interactor?.fetchAchievements()
        
        guard let achievements = presenter?.achievements else {
            XCTFail()
            return
        }
        XCTAssertEqual(achievements.count, 3)
        XCTAssertEqual(achievements[0].level, "1")
        XCTAssertEqual(achievements[0].currentProgress, 10)
        XCTAssertEqual(achievements[0].isAccessible, true)
        XCTAssertEqual(achievements[1].level, "2")
        XCTAssertEqual(achievements[1].currentProgress, 0)
        XCTAssertEqual(achievements[1].isAccessible, false)
        XCTAssertEqual(achievements[2].level, "3")
        XCTAssertEqual(achievements[2].currentProgress, 0)
        XCTAssertEqual(achievements[2].isAccessible, false)
    }

    func testDidErrorOccur() {
        if let errorOccured = presenter?.errorOccured {
            XCTAssert(!errorOccured)
        } else {
            XCTFail()
        }
    }
}

extension StashCodingChallengeTests {
    
    class TestAchievementsPresenter: AchievementsInteractorToPresenterProtocol {
        var errorOccured = false
        var achievements: AchievementEntities?
        
        func achievementsFetchFailed(error: String) {
            errorOccured = true
        }
        
        func achievementsFetched(achievements: AchievementEntities) {
            self.achievements = achievements
        }
    }
}

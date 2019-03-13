//
//  AchievementEntity.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import Foundation

typealias AchievementEntities = [AchievementEntity]

struct AchievementEntity: Codable {
    let level: String
    let currentProgress: Int
    let progressTotal: Int
    let imageURL: String
    let isAccessible: Bool
    
    private enum CodingKeys : String, CodingKey {
        case level, currentProgress = "progress", progressTotal = "total", imageURL = "bg_image_url", isAccessible = "accessible"
    }
}

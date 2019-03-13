//
//  AchievementsViewController.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import UIKit

/// Displays a list of Achievements
class AchievementsViewController: UIViewController {
    
    private let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
    
    var presenter: AchievementsPresenterProtocol?
    
    private var achievements: AchievementEntities = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(AchievementTableViewCell.self, forCellReuseIdentifier: AchievementTableViewCell.reuseID)
        presenter?.viewDidLoad()
    }
}

extension AchievementsViewController: AchievementsViewProtocol {
    
    func displayAchievements(achievements: AchievementEntities) {
        self.achievements = achievements
        tableView.reloadData()
    }
    
    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension AchievementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.reuseID, for: indexPath) as? AchievementTableViewCell else {
            return UITableViewCell()
        }
        if achievements.indices.contains(indexPath.row) {
            cell.set(achievement: achievements[indexPath.row])
        }
        return cell
    }
    
}

extension AchievementsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AchievementTableViewCell.cellHeight
    }

}

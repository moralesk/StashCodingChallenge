//
//  AchievementTableViewCell.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/9/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import UIKit
import SnapKit

/// Cell displaying data for an Achievement
class AchievementTableViewCell: UITableViewCell {
    
    static let reuseID = "AchievementTableViewCell"
    
    static let cellHeight: CGFloat = 215.0
    
    private var isAccessible: Bool = true
    
    private var currentProgress: CGFloat = 0.0
    
    // MARK:- UI Elements
    /// View displayed over all other elements if the Achievement is not accessible
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    /// Container view for all other UI elements
    private let achievementContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    /// Round view displaying level text
    private let achievementLevelView: AchievementLevelView = {
        let view = AchievementLevelView()
        return view
    }()
    
    /// View displaying total progress bar
    private let progressBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    /// View that lies over the total progress bar that displays the current progress
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 115/255, green: 190/255, blue: 95/255, alpha: 1)
        view.layer.cornerRadius = 5.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let currentProgressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private let totalProgressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    // MARK:- Interface
    func set(achievement: AchievementEntity) {
        self.contentView.clipsToBounds = true
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.7
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        achievementLevelView.set(level: achievement.level)
        currentProgressLabel.text = "\(achievement.currentProgress)pts"
        totalProgressLabel.text = "\(achievement.progressTotal)pts"
        currentProgress = CGFloat(achievement.currentProgress) / CGFloat(achievement.progressTotal)
        isAccessible = achievement.isAccessible
        
        if let url = URL(string: achievement.imageURL) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cellImageView.image = image
                    }
                }
            }).resume()
        }
    }
    
    // MARK:- Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setContainerViewConstraints()
        setImageViewConstraints()
        setAchievementLevelViewConstraints()
        setProgressBarConstraints()
        if currentProgress > 0 {
            setProgressConstraints()
        }
        setCurrentProgressLabelConstraints()
        setTotalProgressLabelConstraints()
        if !isAccessible {
            overlayBlurView()
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setContainerViewConstraints()
        setImageViewConstraints()
        setAchievementLevelViewConstraints()
        setProgressBarConstraints()
        if currentProgress > 0 {
            setProgressConstraints()
        }
        setCurrentProgressLabelConstraints()
        setTotalProgressLabelConstraints()
        if !isAccessible {
            overlayBlurView()
        }
    }
    
    // MARK:- Constraints
    private func setContainerViewConstraints() {
        if achievementContainerView.superview == nil {
            contentView.addSubview(achievementContainerView)
        }
        achievementContainerView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().multipliedBy(1.1)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.bottom.equalToSuperview().dividedBy(1.1)
        }
    }
    
    private func setImageViewConstraints() {
        if cellImageView.superview == nil {
            achievementContainerView.addSubview(cellImageView)
        }
        cellImageView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
 
    private func setAchievementLevelViewConstraints() {
        if achievementLevelView.superview == nil {
            achievementContainerView.addSubview(achievementLevelView)
        }
        achievementLevelView.snp.remakeConstraints { (make) in
            make.width.height.equalTo(achievementLevelView.diameter)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().dividedBy(1.6)
        }
    }
    
    private func setProgressBarConstraints() {
        if progressBarView.superview == nil {
            achievementContainerView.addSubview(progressBarView)
        }
        progressBarView.snp.remakeConstraints { (make) in
            make.top.equalTo(achievementLevelView.snp.bottom).multipliedBy(1.2)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(10)
        }
    }
    
    private func setProgressConstraints() {
        if progressView.superview == nil {
            progressBarView.addSubview(progressView)
        }
        progressView.snp.remakeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(currentProgress)
        }
    }
    
    private func setCurrentProgressLabelConstraints() {
        if currentProgressLabel.superview == nil {
            achievementContainerView.addSubview(currentProgressLabel)
        }
        currentProgressLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(progressBarView.snp.bottom).multipliedBy(1.1)
            make.left.equalTo(progressBarView.snp.left)
            make.right.equalTo(progressBarView.snp.centerX)
            make.bottom.equalToSuperview().dividedBy(1.1)
        }
    }
    
    private func setTotalProgressLabelConstraints() {
        if totalProgressLabel.superview == nil {
            achievementContainerView.addSubview(totalProgressLabel)
        }
        totalProgressLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(progressBarView.snp.bottom).multipliedBy(1.1)
            make.left.equalTo(progressBarView.snp.centerX)
            make.right.equalTo(progressBarView.snp.right)
            make.bottom.equalToSuperview().dividedBy(1.1)
        }
    }
    
    private func overlayBlurView() {
        if blurView.superview == nil {
            achievementContainerView.addSubview(blurView)
        }
        blurView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

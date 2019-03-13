//
//  AchievementLevelView.swift
//  StashCodingChallenge
//
//  Created by Kelly Morales on 3/11/19.
//  Copyright © 2019 Kelly Morales. All rights reserved.
//

import UIKit
import SnapKit

/// A round view containing labels do display an Achievement level
class AchievementLevelView: UIView {
    
    let diameter: CGFloat = 95.0
    
    // MARK:- UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        label.text = "Level"
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 45.0, weight: .heavy)
        return label
    }()
    
    // MARK:- Interface
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.layer.cornerRadius = diameter/2
        self.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func set(level: String) {
        levelLabel.text = level
    }
    
    // MARK:- Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setTitleLabelConstraints()
        setLevelLabelConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setTitleLabelConstraints()
        setLevelLabelConstraints()
    }
    
    // MARK:- Constraints
    private func setTitleLabelConstraints() {
        if titleLabel.superview == nil {
            self.addSubview(titleLabel)
        }
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().dividedBy(1.8)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setLevelLabelConstraints() {
        if levelLabel.superview == nil {
            self.addSubview(levelLabel)
        }
        levelLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}

//
//  CatCell.swift
//  TakeHomeProject
//
//  Created by Jonathan Oh on 3/11/18.
//  Copyright © 2018 Jonathan Oh. All rights reserved.
//

import UIKit

class CatCell: UITableViewCell {
    
    static let id = "CatCellID"
    let timeStampLabel = UILabel()
    let catImageView = CustomImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constrainAndSetupViews()
    }
    
    private func constrainAndSetupViews() {
        let labels = [timeStampLabel, titleLabel, descriptionLabel]
        labels.forEach { label in
            label.textAlignment = .center
            label.heightAnchor.constraint(equalToConstant: 21).isActive = true
        }
        
        catImageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [timeStampLabel, catImageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupViewsWithCat(_ cat: Cat) {
        var formattedTimestamp = ""
        for char in cat.timestamp {
            if char == "T" {
                break
            }
            formattedTimestamp.append(char)
        }
        timeStampLabel.text = formattedTimestamp
        catImageView.setImageFromURL(cat.image_url)
        titleLabel.text = cat.title
        descriptionLabel.text = cat.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

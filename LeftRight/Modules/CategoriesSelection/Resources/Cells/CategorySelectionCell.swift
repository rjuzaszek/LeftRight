//
//  CategorySelectionCell.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class CategorySelectionCell: UITableViewCell {
    
    //MARK: - Private properties
    
    @IBOutlet private var label: UILabel!
    @IBOutlet private var tickImage: UIImageView!
    
    private let unselectedTickImage = UIImage(systemName: "heart")
    private let selectedTickImage = UIImage(systemName: "heart.fill")
    
    //MARK: - Public interface
    
    override func prepareForReuse() {
        label.text = ""
        tickImage.image = unselectedTickImage
    }
    
    func setup(viewModel: CategoryViewModel) {
        tickImage.tintColor = .systemPink
        tickImage.image = unselectedTickImage
        label.text = viewModel.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tickImage.image = self.isSelected ? selectedTickImage : unselectedTickImage
    }
}

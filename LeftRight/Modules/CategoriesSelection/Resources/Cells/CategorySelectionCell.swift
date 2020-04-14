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
    @IBOutlet private var thumbnail: UIImageView!
    
    //MARK: - Public interface
    
    override func prepareForReuse() {
        label.text = ""
        thumbnail.image = nil
    }
    
    func setup(viewModel: CategoryViewModel) {
        thumbnail.layer.cornerRadius = 15
        thumbnail.clipsToBounds = true
        //thumbnail.tintColor = .systemPink
        ImageDownloader.download(from: viewModel.thumbnailUrl, completion: { [weak self] in
            self?.thumbnail.image = $0
        })
        label.text = viewModel.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isSelected {
            backgroundColor = UIColor.systemPink.withAlphaComponent(0.5)
        } else {
            backgroundColor = .clear
        }
    }
}

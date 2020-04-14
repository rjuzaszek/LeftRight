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
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.layer.cornerRadius = (bounds.width - 32.0) / 45
        thumbnail.clipsToBounds = true
        ImageDownloader.download(from: viewModel.thumbnailUrl, completion: { [weak self] in
            self?.thumbnail.image = $0
            self?.thumbnail.setCardShadow()
        })
        label.text = viewModel.name.uppercased()
        label.textColor = .systemPink
        label.backgroundColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isSelected {
            backgroundColor = UIColor.systemPink.withAlphaComponent(0.2)
        } else {
            backgroundColor = .clear
        }
    }
}

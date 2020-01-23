//
//  PhotoCell.swift
//  Persistence-Lab
//
//  Created by Chelsi Christmas on 1/22/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    public func configureCell(photo: PhotoInfo) {
        
        imageView.getImage(with: photo.imageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
}

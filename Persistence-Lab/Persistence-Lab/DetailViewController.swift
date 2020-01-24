//
//  DetailViewController.swift
//  Persistence-Lab
//
//  Created by Chelsi Christmas on 1/23/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
//    var likes: Int?
//    var tags: String?
    var photo: PhotoInfo?
    var searchQuery: String?
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var photoInfoLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        
    }
    
    func updateUI() {
        photoInfoLabel.text = searchQuery!
    }
    

    

}

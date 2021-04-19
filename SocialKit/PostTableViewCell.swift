//
//  PostTableViewCell.swift
//  SocialKit
//
//  Created by Rubens Ferreira Ramos on 18/04/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tituloLabel: UILabel!
    
    @IBOutlet weak var corpoLabel: UILabel!
    
    var post: Post?{
        didSet {
            if let post = post{
                tituloLabel.text = post.title
                corpoLabel.text = post.body
            }
        }
    }
    
}

//
//  ArtTableCell.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import UIKit
import SDWebImage

class ArtTableCell: UITableViewCell {

    @IBOutlet weak var imageViewArt: UIImageView!
    @IBOutlet weak var labelArtTitle: UILabel!
    
    var artInfo: ArtInfo! {
        didSet {
            self.labelArtTitle.text = self.artInfo.title
            
            if let imageId = self.artInfo.image_id {
                let imageUrlString = String(format: ServicesConstant.imageUrl, imageId)
                self.imageViewArt.contentMode = .scaleAspectFill
                self.imageViewArt.sd_imageIndicator = SDWebImageActivityIndicator.white
                self.imageViewArt.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage(named: "placeholder")!)
            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

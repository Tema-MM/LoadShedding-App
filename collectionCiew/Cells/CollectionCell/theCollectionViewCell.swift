//
//  theCollectionViewCell.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/12.
//

import UIKit

class theCollectionViewCell: UICollectionViewCell {

    @IBOutlet var theView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var theImage: UIImageView!
    
    static let identifier = "theCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "theCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theView.layer.cornerRadius = 12
        theImage.layer.cornerRadius = 12
    }

    public func configure(with model: Model) {
        self.label.text = model.text
        self.theImage.image = UIImage(named: model.imageName)
    }
    
    public func konfigure(with theModel: Status) {
        //self.label.text = theModel.status
    }
}

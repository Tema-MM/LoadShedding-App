//
//  CollectTableViewCell.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/12.
//

import UIKit

class CollectTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    static let identifier = "CollectTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "CollectTableViewCell", bundle: nil)
    }
    
    func configure(with models: [Model]) {
        self.models = models
        collectionView.reloadData()
    }
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var models = [Model]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(theCollectionViewCell.nib(), forCellWithReuseIdentifier: theCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // colectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: theCollectionViewCell.identifier, for: indexPath) as! theCollectionViewCell
        cell.configure(with: models[indexPath.row])
        //cell.label.text = theModel?.append(Status)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
}

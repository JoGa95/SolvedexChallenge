//
//  PugCollectionViewCell.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import UIKit

class PugCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pugImageView: UIImageView!
    @IBOutlet weak var likeCounterLabel: UILabel!
    var likeButtonAction: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func didLikeButtonTapped(_ sender: Any) {
        likeButtonAction?()
    }
}

//
//  UsersListCell.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

class UsersListCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var nameTextField: UILabel!
    @IBOutlet private weak var postsTitle: UILabel!
    @IBOutlet private weak var postsCount: UILabel!
    
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        nameTextField.text = nil
        postsCount.text = nil
    }
    
    func update(with model: User) {
        self.user = model
        thumbnailImageView.set(model.thumbnailUrl)
        nameTextField.text = model.name
        postsCount.text = String(model.posts?.count ?? 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnailImageView.round()
    }
}

// MARK: - Private functions
extension UsersListCell {
    
    func configureUI() {
        
        containerView.layer.cornerRadius = Constants.Size.appCornerRadius
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        containerView.layer.borderWidth = Constants.Size.borderWidth
        
        nameTextField.font = .preferredFont(forTextStyle: .title2)
        nameTextField.textColor = .label
        
        postsTitle.font = .preferredFont(forTextStyle: .subheadline)
        postsTitle.textColor = .secondaryLabel
        postsTitle.text = KeysForTranslate.postsTitle.localized
        
        postsCount.font = postsTitle.font
        postsCount.textColor = postsTitle.textColor
    }
}

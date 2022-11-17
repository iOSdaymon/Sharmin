//
//  PostsListCell.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

class PostsListCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleTextField: UILabel!
    @IBOutlet private weak var bodyTextField: UILabel!
    
    var postId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleTextField.text = nil
        bodyTextField.text = nil
    }
    
    func update(with model: Post) {
        self.postId = model.userId
        titleTextField.text = model.title
        bodyTextField.text = model.body
    }
}

// MARK: - Private functions
extension PostsListCell {
    
    func configureUI() {
        
        containerView.layer.cornerRadius = Constants.Size.appCornerRadius
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        containerView.layer.borderWidth = Constants.Size.borderWidth
        
        titleTextField.font = .preferredFont(forTextStyle: .title2)
        titleTextField.textColor = .label
        
        bodyTextField.font = .preferredFont(forTextStyle: .subheadline)
        bodyTextField.textColor = .secondaryLabel
        bodyTextField.text = KeysForTranslate.postsTitle.localized
    }
}

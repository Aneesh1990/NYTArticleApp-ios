//
//  ArticleCell.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var nameLabel:    UILabel!
    @IBOutlet var dateLabel:    UILabel!
    @IBOutlet var userImage:    UIImageView?
    //MARK:-  Let & Var
    class var identifier: String { return String(describing: self) }
    class var nib: UINib         { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: ArticleCellViewModel? {
        didSet {
            headingLabel.text = cellViewModel?.heading
            nameLabel.text    = cellViewModel?.userName
            dateLabel.text    = cellViewModel?.createdAt
            userImage?.loadImageUsingCache(withUrl: cellViewModel?.imageURL ?? "")
        }
    }
    //MARK:-  Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        headingLabel.text = nil
        nameLabel.text = nil
        dateLabel.text = nil
    }
    //MARK:-  Private Methods
    fileprivate func initView() {
        // Cell view customization
        backgroundColor = .clear
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
}

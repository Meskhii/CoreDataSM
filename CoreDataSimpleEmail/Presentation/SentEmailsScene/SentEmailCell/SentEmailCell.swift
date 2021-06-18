//
//  SentEmailCell.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class SentEmailCell: UITableViewCell {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with email: Email){
        subjectLabel.text = email.subject
        messageLabel.text = email.emailContext
    }
    
}

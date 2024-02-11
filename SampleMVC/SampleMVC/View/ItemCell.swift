//
//  ItemCell.swift
//  SampleMVC
//
//  Created by Sandipan Roy Chowdhury on 06/02/24.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemName : UILabel!
    @IBOutlet weak var itemQuantity : UILabel!
    @IBOutlet weak var itemPrice : UILabel!
    @IBOutlet weak var itemIsOnSale : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

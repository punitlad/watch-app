
import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    var item:Item
    
    required init(coder aDecoder: NSCoder) {
        self.item = Item(coder: aDecoder)
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        self.item = Item(with: reuseIdentifier)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindTo(item:Item) {
        self.item = item
        
        if (item.checked) {
            let attributes = [ NSStrikethroughStyleAttributeName : 1 ]
            let title = NSAttributedString(string: item.name, attributes: attributes)
            
            self.itemNameLabel.attributedText = title
            self.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            self.itemNameLabel.text = item.name
            self.accessoryType = UITableViewCellAccessoryType.None
        }
    }

    func rebind() {
        self.bindTo(self.item)
    }

}

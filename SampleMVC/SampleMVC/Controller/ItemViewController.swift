//
//  ViewController.swift
//  SampleMVC
//
//  Created by Sandipan Roy Chowdhury on 06/02/24.
//

import UIKit

enum ITEMTYPE:Int,CaseIterable {
    case SHIRT
    case TROUSER
    case SHORTS
    case SHOES
    case ACCESSORIES
    var sectionTitle: String {
            switch self {
            case .SHIRT: return "Shirt"
            case .TROUSER: return "Trouser"
            case .SHORTS: return "Shorts"
            case .SHOES: return "Shoes"
            case .ACCESSORIES: return "Accessories"
            }
        }
}
class ItemViewController: UIViewController {

    @IBOutlet weak var ItemTblView : UITableView!
    var ItemData = [String:[Item]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MVC Example"
        // Do any additional setup after loading the view.
        ItemTblView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        ItemData = ["Shirt":
                        [Item(idVal: "147575", name: "Lorem Ipsum club shirt", image: "https://via.placeholder.com/300x150", price: 1200, quantity: 2, category: ITEMTYPE.SHIRT.sectionTitle, isOnSale: true),
                        Item(idVal: "235764", name: "Lorem Ipsum club shirt", image: "https://via.placeholder.com/300x150", price: 3200, quantity: 5, category: ITEMTYPE.SHIRT.sectionTitle, isOnSale: false),
                        Item(idVal: "262746", name: "Lorem Ipsum club shirt", image: "https://via.placeholder.com/300x150", price: 1700, quantity: 1, category: ITEMTYPE.SHIRT.sectionTitle, isOnSale: true),
                        Item(idVal: "776346", name: "Lorem Ipsum club shirt", image: "https://via.placeholder.com/300x150", price: 2500, quantity: 10, category: ITEMTYPE.SHIRT.sectionTitle, isOnSale: true)],
            "Trouser":
                        [Item(idVal: "346756", name: "Lorem Ipsum club Trouser", image: "https://via.placeholder.com/300x150", price: 1000, quantity: 1, category: ITEMTYPE.TROUSER.sectionTitle, isOnSale: true),
                         Item(idVal: "848939", name: "Lorem Ipsum club Trouser", image: "https://via.placeholder.com/300x150", price: 3200, quantity: 7, category: ITEMTYPE.TROUSER.sectionTitle, isOnSale: false)],
            "Shorts":
                        [Item(idVal: "290946", name: "Lorem Ipsum club Shorts", image: "https://via.placeholder.com/300x150", price: 900, quantity: 3, category: ITEMTYPE.SHORTS.sectionTitle, isOnSale: false),
                         Item(idVal: "345987", name: "Lorem Ipsum club Shorts", image: "https://via.placeholder.com/300x150", price: 1400, quantity: 5, category: ITEMTYPE.SHORTS.sectionTitle, isOnSale: true)],
            "Shoes":
                        [Item(idVal: "345867", name: "Lorem Ipsum club Shoes", image: "https://via.placeholder.com/300x150", price: 1400, quantity: 1, category: ITEMTYPE.SHOES.sectionTitle, isOnSale: true),
                         Item(idVal: "687978", name: "Lorem Ipsum club Shoes", image: "https://via.placeholder.com/300x150", price: 5000, quantity: 2, category: ITEMTYPE.SHORTS.sectionTitle, isOnSale: true),
                         Item(idVal: "120987", name: "Lorem Ipsum club Shoes", image: "https://via.placeholder.com/300x150", price: 1100, quantity: 7, category: ITEMTYPE.SHOES.sectionTitle, isOnSale: false)],
            "Accessories":
                        [Item(idVal: "868949", name: "Lorem Ipsum club Accessories", image: "https://via.placeholder.com/300x150", price: 1500, quantity: 4, category: ITEMTYPE.ACCESSORIES.sectionTitle, isOnSale: true),
                         Item(idVal: "457637", name: "Lorem Ipsum club Accessories", image: "https://via.placeholder.com/300x150", price: 2200, quantity: 6, category: ITEMTYPE.ACCESSORIES.sectionTitle, isOnSale: true)]]
        
        
        
    }
}

extension ItemViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ITEMTYPE.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        _ = tableView.frame
        let label = UILabel(frame: CGRect(x: 15, y: -10, width: tableView.frame.width, height: 20))
        _ = ITEMTYPE(rawValue:section)
        header.addSubview(label)
        label.backgroundColor = UIColor.clear
        label.text = ITEMTYPE(rawValue: section)?.sectionTitle
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tempArr = ItemData[ITEMTYPE(rawValue: section)?.sectionTitle ?? ""] {
            return tempArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: ItemCell, forItemAt indexPath: IndexPath) {
        if let tempArr = ItemData[ITEMTYPE(rawValue: indexPath.section)?.sectionTitle ?? ""] {
            let item = tempArr[indexPath.row]
            cell.itemName.text = item.name
            cell.itemPrice.text = "Rs. \(item.price )"
            cell.itemQuantity.text = "Quantity: \(item.quantity)"
            let result = (item.isOnSale == true) ? "On Sale!!!" : "No Offers!!!"
            cell.itemIsOnSale.text = result
            downloadImage(imageUrl: item.image, completion: { image in
                DispatchQueue.main.async {
                    cell.itemImage.image = image
                }
            })
            
        }
    }
    
    func downloadImage(imageUrl:String, completion:@escaping(UIImage?)->Void){
        if let url = URL(string: imageUrl) {
            downloadImageAsynchronously(from: url) { image in
                // Use the downloaded image
                if let tempimage = image {
                    completion(tempimage)
                } else {
                    // Image download failed
                    print("Failed to download image")
                    completion(nil)
                }
            }
        } else {
            print("Invalid URL")
        }
    }
}


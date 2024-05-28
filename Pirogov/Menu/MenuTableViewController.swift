//
//  MenuTableViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 17.05.2024.
//

import UIKit


class MenuTableViewController: UITableViewController {
    
    
    
    let productPies = Pies.fetchPies()
    let productCakes = Cakes.fetchCakes()
    
//    let productPies = Menu.setupPies()
//    let productCakes = Menu.setupCakes()
    
    
    
    lazy var menuCollectionView = MenuCollectionView()
//
//    let menuGroup = Group.setupGroup()


    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        
        


    }
    
    func updateTable() {
        tableView.reloadData()
        print("update")
    }
    
    // MARK: - UITableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    // MARK: - UITableView Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productPies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MenuTableViewCell {
            
            switch menuCollectionView.selectedIndexGroup {
            case 0:
                let pies = productPies[indexPath.row]
    
                cell.nameProduct.text = pies.name
                cell.priceLabel.text = pies.price
                
                print("пироги")
                break
            case 1:
                let cakes = productCakes[indexPath.row]
                
                cell.nameProduct.text = cakes.name
                cell.priceLabel.text = cakes.price
                
                print("торты")
                break
            default: break
            }
          

            
            
//            let product = productPies[indexPath.row]
//        
//            cell.nameProduct.text = product.name
//            cell.priceLabel.text = product.price
            
            
//     ------------------------------------------------
//            let product2 = productCakes[indexPath.row]
//        
//            cell.nameProduct.text = product2.name
//            cell.priceLabel.text = product2.price
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 150, height: headerView.frame.height)
        label.font = .systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch section {
        case 0:
            label.text = "Постные пироги"
        case 1:
            label.text = "Пироги"
        case 2:
            label.text = "Наборы пирогов"
        default: break
        }
            
        tableView.addSubview(headerView)

        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15)
        ])
        
        return headerView
    }
    

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailProductViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.nameProduct.text = productPies[indexPath.row].name
            vc.compositionProduct.text = "Состав: \(productPies[indexPath.row].composition ?? "")"
            vc.nameTitleButton = "В корзину   \(productPies[indexPath.row].price ?? "")"
        }
        
        self.show(vc, sender: tableView)
        
        print("check")
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



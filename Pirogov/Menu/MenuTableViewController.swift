//
//  MenuTableViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 17.05.2024.
//

import UIKit

class MenuTableViewController: UITableViewController {

    
    let menu = GroupProducts.setup()
    
    private var selectedIndex: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
    }
    
    // MARK: - Reload Table
    func updateTable(by index: Int) {
        selectedIndex = index
//        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
    }
    
    
    // MARK: - Метод расчета высоты таблицы
    
        func calculateTableHeight() -> CGFloat {
            let numberOfSections = self.numberOfSections(in: tableView)
            var totalHeight: CGFloat = 0.0
            
            for section in 0..<numberOfSections {
                let numberOfRows = self.tableView(tableView, numberOfRowsInSection: section)
                let headerHeight = self.tableView(tableView, heightForHeaderInSection: section)
                totalHeight += headerHeight
                
                for _ in 0..<numberOfRows {
                    let rowHeight = self.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: section))
                    totalHeight += rowHeight
                }
            }
            
            return totalHeight
        }
    
    
    
    
    // MARK: - UITableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    // MARK: - UITableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return menu.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menu[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        let products = menu[indexPath.section][indexPath.row]
        cell.configureCell(model: products)
        
        return cell
        }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 150, height: headerView.frame.height)
        label.font = .systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let sectionTitles = ["Пироги", "Торты", "Десерты", "Выпечка", "Киши", "Пицца", "Напитки"]
        label.text = sectionTitles[section]
            
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
            
            let product = menu[indexPath.section][indexPath.row]
            vc.configure(model: product)
            
            self.show(vc, sender: tableView)
            }
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






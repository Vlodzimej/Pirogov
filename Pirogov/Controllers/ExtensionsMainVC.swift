//
//  ExtensionsMainVC.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 04.09.2024.
//

import Foundation
import UIKit



// MARK: - TableView DataSource Methods

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailProductViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let product = menu[indexPath.section][indexPath.row]
            vc.configure(model: product)
            
            self.showDetailViewController(vc, sender: nil)
            }
        }
    
    
    //  MARK: - Методы для скроллинга таблицы
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        onScroll?(section)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let visibleSections = tableView.indexPathsForVisibleRows?.map { $0.section } ?? []
        let visibleSection = visibleSections.sorted().first ?? 0
        onScroll?(visibleSection)
    }
}



    // MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.id, for: indexPath) as? ProductsTableViewCell else { return UITableViewCell() }
        
        let products = menu[indexPath.section][indexPath.row]
        cell.configureCell(model: products)
        
        return cell
    }
}
    
    
    

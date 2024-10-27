//
//  ViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit
import FirebaseFirestore

// MARK: - MainViewController
class MainViewController: UIViewController {
    
    // MARK: Properties
    var saleCollectionView = SaleCollectionView()
    var menuCollectionView = MenuCollectionView()

    let productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.id)
        return tableView
    }()
    
    var menu = GroupProducts.Menu()
    
    var isScrollingTableView = false
    
    var menuCollectionViewTopConstraint: NSLayoutConstraint!
    var saleCollectionViewTopConstraint: NSLayoutConstraint!
    
    var onScroll: ((Int) -> Void)?
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
                observeQuery()
            }
        }
    }
    
    private var listener: ListenerRegistration?
    private var documents: [DocumentSnapshot] = []
    
    private var products: [Product] = []
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
        menuCollectionView.didSelectItem = { [weak self] index in
            guard let self = self else { return }
            self.isScrollingTableView = false
            self.productsTableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
        }
        
        self.onScroll = { [weak self] section in
            guard let self = self, !self.isScrollingTableView else { return }
            self.menuCollectionView.menuCollectionView.selectItem(at: IndexPath(item: section, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
        
        menuCollectionView.set(cell: MenuProducts.fetchMenu())
        
        setupSaleCollectionView()
        setupCollectionView()
        setupCustomTableView()
        
        query = baseQuery()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        observeQuery()
    }
    
    private func observeQuery() {
        guard let query else { return }
        stopObserving()
        
        listener = query.addSnapshotListener { [weak self] snapshot, error in
            guard let self, let snapshot else {
                debugPrint("Error fetching snapshot results: \(error!)")
                return
            }
            
            let models = snapshot.documents.map { (document) -> Product in
                let model: Product?
                do {
                    model = try document.data(as: Product.self)
                } catch {
                    fatalError(
                        "Unable to initialize type \(Product.self) with dictionary \(document.data()): \(error)"
                    )
                }
                
                if var model, let id = Int(document.documentID) {
                    model.id = id
                    return model
                } else {
                    // Don't use fatalError here in a real app.
                    fatalError("Missing document of type \(Product.self) at \(document.reference.path)")
                }
            }
            self.products = models
            self.documents = snapshot.documents
            self.menu = GroupProducts.setup(with: models)
            
            productsTableView.reloadData()
        }
    }
    
    private func stopObserving() {
        listener?.remove()
    }
    
    private func baseQuery() -> Query {
        return Firestore.firestore().collection("products").limit(to: 50)
    }
    
    //  MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print("offset = \(yOffset)")
        if yOffset < 180 {
            menuCollectionViewTopConstraint.constant = 190 - yOffset
            print("Доходит до = \(menuCollectionViewTopConstraint.constant)")
        } else {
            menuCollectionViewTopConstraint.constant = 10
        }
    }
}

// MARK: - Settings Constraints
extension MainViewController {
    
    private func setupSaleCollectionView() {
        view.addSubview(saleCollectionView)
        saleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        saleCollectionViewTopConstraint = saleCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            saleCollectionViewTopConstraint, // !
            saleCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            saleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            saleCollectionView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(menuCollectionView)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        menuCollectionViewTopConstraint = menuCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190)
        
        NSLayoutConstraint.activate([
            menuCollectionViewTopConstraint,
            menuCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuCollectionView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    private func setupCustomTableView() {
        view.addSubview(productsTableView)
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}






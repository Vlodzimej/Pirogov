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
    /// Имя коллекции в базе данных, к которой подключаемся для получения данных
    let firestoreProductCollectionName = "products"
    /// Слушатель для базы данных Firestore
    private var listener: ListenerRegistration?
    /// Список «документов» в коллекции базы данных, к которой подключились (см. метод baseQuery())
    /// Это пока не используется, но пусть будет, чтобы не потерять.
    private var documents: [DocumentSnapshot] = []
    
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
        // Перед отображением вьюшки подписываемся на прослушку базы данных
        observeQuery()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Если эта вьюшка скрывается, тогда удаляем слушателя, чтобы небыло ненужной работы в фоне
        stopObserving()
    }
    
    // MARK: Private methods
    // Метод подписки слушателя (listener) на события базы данных Firestore
    private func observeQuery() {
        guard let query else { return }
        stopObserving()
        
        // Подписываем слушателя
        listener = query.addSnapshotListener { [weak self] snapshot, error in
            // snapshot это слепок базы данных в определённый момент времени
            // этим моментом может быть момент подключения, либо когда у БД происходят какие-то изменения (редактирование/добавление/удаление)
            guard let self, let snapshot else {
                debugPrint("Error fetching snapshot results: \(error!)")
                return
            }
            
            // У слепка есть свойство documents в котором содержатся записи (в нашем случае это продукты)
            // Начинаем обход каждого документа и пробразуем этот массив докуметов в массив наших моделей
            let models = snapshot.documents.map { (document) -> Product in
                let model: Product?
                do {
                    // Приводим неизвестный тип к ожидаемому. В нашем случае это Product
                    model = try document.data(as: Product.self)
                } catch {
                    fatalError(
                        "Unable to initialize type \(Product.self) with dictionary \(document.data()): \(error)"
                    )
                }
                // Если всё ок, то достаём из документа идентификатор и назначаем полученной модели, так как само содержимое документа в себе его не содержит,
                // соответственно айдишник неоткуда декодировать. Это не очень прикольно и нужно получше разобратсья с этим вопросом, но пока можно так.
                if var model, let id = Int(document.documentID) {
                    model.id = id
                    return model
                } else {
                    // Don't use fatalError here in a real app.
                    fatalError("Missing document of type \(Product.self) at \(document.reference.path)")
                }
            }
            self.documents = snapshot.documents
            
            /// Формируем данные для таблицы из полученных от БД моделей
            self.menu = GroupProducts.setup(with: models)
            /// Обновляем таблицу
            productsTableView.reloadData()
        }
    }
    
    private func stopObserving() {
        listener?.remove()
    }
    
    private func baseQuery() -> Query {
        return Firestore.firestore().collection(firestoreProductCollectionName).limit(to: 50)
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






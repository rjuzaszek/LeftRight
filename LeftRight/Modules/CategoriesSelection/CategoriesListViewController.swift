//
//  CategoriesListViewController.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesListViewController: UIViewController {
    
    //MARK: - Public properties
    
    weak var coordinator: CategoriesListCoordination?
    var viewModel: CategoriesListViewModelProtocol?
    
    //MARK: - Private properties
    
    @IBOutlet private var tableView: UITableView!
    private let refreshView = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        registerCells()
        setupTableView()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setPlayNavigationButton()
    }
}

//MARK: - Private funcitions
private extension CategoriesListViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        setupRefreshView()
        registerCells()
    }
    
    func registerCells() {
        for cell in CategoriesList.Cells.allCases {
            let nib = UINib(nibName: cell.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cell.rawValue)
        }
    }
    
    func setupRefreshView() {
        refreshView.addTarget(self, action: #selector(refreshTrigerred), for: .valueChanged)
        tableView.refreshControl = refreshView
    }
    
    @objc func refreshTrigerred() {
        
    }
    
    func setPlayNavigationButton() {
        let playButton = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = playButton
    }
    
    @objc func startGame() {
        guard let viewModel = viewModel else { return }
        var selectedCategoriesUrls = [String]()
        tableView.indexPathsForSelectedRows?.map({ $0.row }).forEach({
            //selectedCategoriesUrls.append(viewModel.categoryUrl(forIndex: $0))
        })
        coordinator?.startGame(categoriesUrls: selectedCategoriesUrls)
    }
    
    func setupViewModel() {
        viewModel = CategoriesListViewModel(categoriesService: MockedCategories())
        
        viewModel?.categories.drive(onNext: { categories in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel?.isFetching.drive(refreshView.rx.isRefreshing).disposed(by: disposeBag)
        
//        viewModel?.isFetching.drive(onNext: { isFetching in
//            isFetching ? self.tableView.refreshControl?.beginRefreshing() : self.tableView.refreshControl?.endRefreshing()
//        }).disposed(by: disposeBag)
    }
}

//MARK: - Table view delegate & data source
extension CategoriesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCategories ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesList.Cells.selection.rawValue, for: indexPath)
        if let categoryViewModel = viewModel?.categoryViewModel(forIndex: indexPath.row) {
            (cell as? CategorySelectionCell)?.setup(viewModel: categoryViewModel)
        }
        return cell
    }
}

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
        bindViewModel()
        setPlayNavigationButton()
    }
}

//MARK: - Private funcitions
private extension CategoriesListViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.estimatedRowHeight = UIScreen.main.bounds.width / 2.7
        tableView.rowHeight = UIScreen.main.bounds.width / 2.7
        tableView.separatorStyle = .none
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
        viewModel?.isPlayButtonEnabled.drive(playButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    @objc func startGame() {
        guard let selectedCategories = viewModel?.selectedCategories else { return }
        coordinator?.startGame(categories: selectedCategories)
    }
    
    func bindViewModel() {
        viewModel = CategoriesListViewModel(categoriesService: FirebaseCategoriesService())
        viewModel?.categories.drive(onNext: { [weak self] _ in self?.tableView.reloadData() }).disposed(by: disposeBag)
        viewModel?.isFetching.drive(refreshView.rx.isRefreshing).disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] _ in self?.setSelectedIndexes() }).disposed(by: disposeBag)
        tableView.rx.itemDeselected.subscribe(onNext: { [weak self] _ in self?.setSelectedIndexes() }).disposed(by: disposeBag)
    }
    
    func setSelectedIndexes() {
        let selectedIndexes = tableView.indexPathsForSelectedRows?.map({ $0.row })
        viewModel?.selectedIndexes.accept(selectedIndexes ?? [])
    }
}

//MARK: - Table view delegate & data source
extension CategoriesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCategories ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesList.Cells.selection.rawValue, for: indexPath)
        guard let categoryViewModel = viewModel?.categoryViewModel(forIndex: indexPath.row) else { return cell }
        (cell as? CategorySelectionCell)?.setup(viewModel: categoryViewModel)
        return cell
    }
}

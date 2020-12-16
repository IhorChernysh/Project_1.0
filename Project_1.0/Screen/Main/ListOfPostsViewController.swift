//
//  ListOfPostsViewController.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import SnapKit
import JGProgressHUD
import CoreData
import RxSwift

class ListOfPostsViewController: UIViewController {

    // MARK: - UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(ListOfPostsTableViewCell.self)
        return tableView
    }()
    
    private let progressHud = JGProgressHUD(style: .dark)
    
    // MARK: - Properties
    
    private var fetchedResultController: NSFetchedResultsController<PostInfoCD>?
    private var listOfPostsViewModel: ListOfPostsViewModel!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(viewModel: ListOfPostsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.listOfPostsViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        fetchPostsFromAPI()
        
        setupUI()
        setNavigation()
    }
    
    // MARK: - Methods
    
    private func setupBinding() {
        listOfPostsViewModel
            .activityIndicatorObservable
            .subscribe(onNext: { [weak self] startActivity in
                guard let self = self else { return }
                startActivity ? self.view.addSpinner(progressHud: self.progressHud) :                 self.view.removeSpinner(progressHud: self.progressHud)
            })
            .disposed(by: disposeBag)
        
        listOfPostsViewModel
            .listOfPostsObservable
            .subscribe(onNext: { [weak self] postsInfo in
                guard let self = self else { return }
                self.loadPostsFromCoreData()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                
                let alertVC = self.alert(title: "Something wrong.", message: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default)], style: .alert)
                self.present(alertVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadPostsFromCoreData() {
        fetchedResultController = CoreDataService.shared.postsInfoFetchedResultController()
        fetchedResultController?.delegate = self
        do {
            try fetchedResultController?.performFetch()
            tableView.reloadData()
        } catch {
            fatalError("Failed fetching content items with error: \(error)")
        }
    }
    
    private func fetchPostsFromAPI() {
        listOfPostsViewModel.fetchPostsInfo()
    }
}

// MARK: - UITableViewDataSource

extension ListOfPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultController?.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(ListOfPostsTableViewCell.self, for: indexPath) else { return ListOfPostsTableViewCell() }
        if let postInfoCD = fetchedResultController?.object(at: indexPath) {
            cell.configure(info: postInfoCD)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListOfPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let postInfoCD = fetchedResultController?.object(at: indexPath) {
            listOfPostsViewModel.selectPostInfoSubject.onNext(postInfoCD)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension ListOfPostsViewController: NSFetchedResultsControllerDelegate {
}

// MARK: - Setup UI

private extension ListOfPostsViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setNavigation() {
        navigationItem.title = "Posts"
    }
}

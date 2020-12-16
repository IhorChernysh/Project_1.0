//
//  PostDetailsViewController.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import SnapKit
import JGProgressHUD
import CoreData
import RxSwift

enum DetailsType {
    case postInfo
    case profileInfo
    case comments
}

class PostDetailsViewController: UIViewController {

    // MARK: - UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.register(PostDetailsTableViewCell.self)
        tableView.register(ListOfPostsTableViewCell.self)
        return tableView
    }()
    
    private let progressHud = JGProgressHUD(style: .dark)
    
    // MARK: - Properties
    
    private var fetchedResultController: NSFetchedResultsController<UserCommentsCD>?
    private var postDetailsViewModel: PostDetailsViewModel!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(postDetailsViewModel: PostDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.postDetailsViewModel = postDetailsViewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        fetchUserInfoFromAPI()
        
        setupUI()
        setNavigation()
    }
    
    // MARK: - Methods
    
    private func setupBinding() {
        postDetailsViewModel
            .activityIndicatorObservable
            .subscribe(onNext: { [weak self] startActivity in
                guard let self = self else { return }
                startActivity ? self.view.addSpinner(progressHud: self.progressHud) :                 self.view.removeSpinner(progressHud: self.progressHud)
            })
            .disposed(by: disposeBag)
        
        postDetailsViewModel
            .pickedPostInfoObservable
            .subscribe(onNext: { [weak self] postInfoCD in
                guard let self = self else { return }
                self.tableView.reloadData()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                let alertVC = self.alert(title: "Something wrong.", message: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default)], style: .alert)
                self.tableView.isHidden = true
                self.present(alertVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        postDetailsViewModel
            .postDetailInfoRelay
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchUserInfoFromAPI() {
        postDetailsViewModel.checkContainsProfileInfo()
    }
}

// MARK: - UITableViewDataSource

extension PostDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return postDetailsViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch postDetailsViewModel.sections[section] {
        case .postInfo:
            guard postDetailsViewModel.postDetailInfoRelay.value?.postInfo != nil else { return 0 }
            return 1
        case .profileInfo:
            guard postDetailsViewModel.postDetailInfoRelay.value?.userInfo != nil else { return 0 }
            return 1
        case .comments:
            return postDetailsViewModel.postDetailInfoRelay.value?.comments?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let infoToSet = postDetailsViewModel.sections[indexPath.section]
        switch infoToSet {
        case .postInfo:
            guard let cell = tableView.dequeue(ListOfPostsTableViewCell.self, for: indexPath) else { return ListOfPostsTableViewCell() }
            if let postInfo = postDetailsViewModel.postDetailInfoRelay.value?.postInfo {
                cell.configureForPostInfo(postInfoCD: postInfo)
            }
            cell.selectionStyle = .none
            return cell
        case .profileInfo:
            guard let cell = tableView.dequeue(PostDetailsTableViewCell.self, for: indexPath) else { return PostDetailsTableViewCell() }
            if let userInfo = postDetailsViewModel.postDetailInfoRelay.value?.userInfo {
                cell.configure(userInfoCD: userInfo)
            }
            cell.selectionStyle = .none
            return cell
        case .comments:
            guard let cell = tableView.dequeue(ListOfPostsTableViewCell.self, for: indexPath) else { return ListOfPostsTableViewCell() }
            if let userCommentsCD = postDetailsViewModel.postDetailInfoRelay.value?.comments?[indexPath.row] {
                cell.configureForComments(userComment: userCommentsCD)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension PostDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if postDetailsViewModel.sections[section] == .comments {
            let textLabel = UILabel(text: "Comments", font: .boldSystemFont(ofSize: 24), numberOfLines: 1, textColor: .black)
            let headerView = UIView()
            headerView.addSubview(textLabel)
            textLabel.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalToSuperview()
            }
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if postDetailsViewModel.sections[section] == .comments {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Setup UI

private extension PostDetailsViewController {
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
        navigationItem.title = "Detail"
    }
}

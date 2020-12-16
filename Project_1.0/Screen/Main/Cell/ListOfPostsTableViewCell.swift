//
//  ListOfPostsTableViewCell.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import SnapKit

class ListOfPostsTableViewCell: UITableViewCell {

    // MARK: - UI Properties
    
    private let mainTitleLabel = UILabel(text: "", font: .systemFont(ofSize: 18), textColor: .black)
    
    private let descriptionLabel = UILabel(text: "", font: .systemFont(ofSize: 14), numberOfLines: 2, textColor: .gray)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainTitleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(info: PostInfoCD) {
        mainTitleLabel.text = info.title
        descriptionLabel.text = info.body
    }
    
    func configureForComments(userComment: UserCommentsCD) {
        mainTitleLabel.text = userComment.name
        descriptionLabel.text = userComment.body
        
        setNumberOfLinesZero()
    }
    
    func configureForPostInfo(postInfoCD: PostInfoCD) {
        mainTitleLabel.text = postInfoCD.title
        descriptionLabel.text = postInfoCD.body
        
        setNumberOfLinesZero()
    }
    
    private func setNumberOfLinesZero() {
        mainTitleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
}

// MARK: - Setup UI

private extension ListOfPostsTableViewCell {
    func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

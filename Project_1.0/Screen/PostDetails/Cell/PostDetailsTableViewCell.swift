//
//  PostDetailsTableViewCell.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//

import SnapKit

class PostDetailsTableViewCell: UITableViewCell {

    // MARK: - UI Properties
    
    private let mainTitleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
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
    
    func configure(userInfoCD: UserInfoCD) {
        setAttributedText(userInfoCD: userInfoCD)
    }
    
    private func setAttributedText(userInfoCD: UserInfoCD) {
        mainTitleLabel.numberOfLines = 0
        
        let fontAtrribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let mutableString = NSMutableAttributedString(string: "", attributes: fontAtrribute)
        
        if let name = userInfoCD.name {
            mutableString.append(NSAttributedString(string: "Name: \(name)\n"))
        }
        if let email = userInfoCD.email {
            mutableString.append(NSAttributedString(string: "Email: \(email)\n"))
        }
        if let phone = userInfoCD.phone {
            mutableString.append(NSAttributedString(string: "Phone: \(phone)\n"))
        }
        if let website = userInfoCD.website {
            mutableString.append(NSAttributedString(string: "Website: \(website)\n"))
        }
        
        if let company = userInfoCD.company?.name {
            mutableString.append(NSAttributedString(string: "Company: \(company)"))
        }
        
        mainTitleLabel.attributedText = mutableString
    }
}

// MARK: - Setup UI

private extension PostDetailsTableViewCell {
    func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

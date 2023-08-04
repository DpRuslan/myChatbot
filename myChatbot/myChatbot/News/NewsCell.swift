//
//  NewsCell.swift
//

import UIKit

// MARK: UITableViewCell

class NewsCell: UITableViewCell {
    private var titleLabel = UILabel(frame: .zero)
    private var customImageView = UIImageView(frame: .zero)
    var item: News! {
        didSet {
            titleLabel.text = item.title
            customImageView.image = item.image
            setupUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(customImageView)
        addSubview(titleLabel)
        
        customImageView.contentMode = .scaleToFill
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension NewsCell: CustomLabel {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: customImageView.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            customImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            customImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
// MARK: setupUI
    
    private func setupUI() {
        setCustomLabel(
            label: titleLabel,
            title: item.title,
            fontSize: 14,
            textColor: .black,
            numbersOfLines: 0,
            alignment: nil
        )
    }
}

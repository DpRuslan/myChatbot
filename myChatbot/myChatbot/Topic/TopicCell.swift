//
//  TopicCell.swift
//

import UIKit

struct Topic {
    var selectorImage: UIImage
    var text: String
    var colorsSet: UIImage
    
}

// MARK: UITableViewCell

class TopicCell: UITableViewCell {
    private var selectorImageView = UIImageView(frame: .zero)
    private var topicLabel = UILabel(frame: .zero)
    private var colorsImageView = UIImageView(frame: .zero)
    var topic: Topic! {
        didSet {
            selectorImageView.image = topic.selectorImage
            colorsImageView.image = topic.colorsSet
            setCustom()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectorImageView.contentMode = .scaleToFill
        colorsImageView.contentMode = .scaleToFill
        
        addSubview(selectorImageView)
        addSubview(topicLabel)
        addSubview(colorsImageView)
        
        selectorImageView.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        colorsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: CustomLabel

extension TopicCell: CustomLabel {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            colorsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            colorsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            colorsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            selectorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            selectorImageView.centerYAnchor.constraint(equalTo: colorsImageView.centerYAnchor),
            
            topicLabel.leadingAnchor.constraint(equalTo: selectorImageView.trailingAnchor, constant: 10),
            topicLabel.centerYAnchor.constraint(equalTo: colorsImageView.centerYAnchor)
        ])
    }
    
    private func setCustom() {
        setCustomLabel(
            label: topicLabel,
            title: topic.text,
            fontSize: 17,
            textColor: .black,
            numbersOfLines: nil,
            alignment: nil
        )
    }
}

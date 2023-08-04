//
//  ImageCell.swift
//

import UIKit

struct ImageMessage {
    var isSending: Bool
    var image1: UIImage?
    var image2: UIImage?
    var text: String?
}

// MARK: UITableViewCell

class ImageCell: UITableViewCell {
    private var chatLabel = UILabel(frame: .zero)
    private var imageView1 = UIImageView(frame: .zero)
    private var imageView2 = UIImageView(frame: .zero)
    private var imageView1Bottom: NSLayoutConstraint!
    
    var imageMessage: ImageMessage! {
        didSet {
            if imageMessage.isSending {
                chatLabel.isHidden = false
                imageView1.isHidden = true
                imageView2.isHidden = true
                imageView1Bottom.isActive = false
                setupUI()
                
            } else {
                imageView1.image = imageMessage.image1
                imageView2.image = imageMessage.image2
                chatLabel.isHidden = true
                imageView1.isHidden = false
                imageView2.isHidden = false
                imageView1Bottom.isActive = true
            }
            
            imageView1.contentMode = .scaleToFill
            imageView2.contentMode = .scaleToFill
            imageView1.clipsToBounds = true
            imageView2.clipsToBounds = true
            imageView1.layer.cornerRadius = 10
            imageView2.layer.cornerRadius = 10
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(chatLabel)
        addSubview(imageView1)
        addSubview(imageView2)
        
        chatLabel.translatesAutoresizingMaskIntoConstraints       = false
        imageView1.translatesAutoresizingMaskIntoConstraints      = false
        imageView2.translatesAutoresizingMaskIntoConstraints      = false
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: setupConstraints

extension ImageCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chatLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            chatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            imageView1.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.47),
            imageView1.heightAnchor.constraint(equalToConstant: 140),
            
            imageView2.centerYAnchor.constraint(equalTo: imageView1.centerYAnchor),
            imageView2.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor, constant: 10),
            imageView2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.47),
            imageView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView2.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        imageView1Bottom = imageView1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
    }
}

// MARK: CustomLabel

extension ImageCell: CustomLabel {
    private func setupUI() {
        setCustomLabel(
            label: chatLabel,
            title: "Promt: \(imageMessage.text!)",
            fontSize: 16,
            textColor: .black,
            numbersOfLines: 0,
            alignment: nil
        )
    }
}

